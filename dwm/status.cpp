#include <iostream>
#include <ctime>
#include <regex>
#include <fstream>
#include <math.h>
#include <alsa/asoundlib.h>
#include <curl/curl.h>
#include <sys/utsname.h>
#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;

std::string get_date() {
    std::time_t tm = std::time(nullptr);
    char date_time[32];
    
    std::strftime(date_time, sizeof(date_time), "%b %d, %a %I:%M %P", std::localtime(&tm));
    
    return (std::string) date_time;
}

int get_npkgs() {
    unsigned int number_of_pkgs = 0;
    
    for (auto& dir : fs::directory_iterator("/var/db/pkg"))
        for (auto& pkgs : fs::directory_iterator(dir))
            number_of_pkgs++;
   
    return number_of_pkgs;
}

std::vector<int> get_mem() {
    std::smatch matches;
    std::vector<int> mem_info;
    
    std::ifstream fin ("/proc/meminfo", std::ifstream::in);
    
    std::string data;
    while (std::getline(fin, data)) {
        if (std::regex_match(data, matches, (std::regex) "^(MemTotal|MemFree|Buffers|Cached|Slab):.*"))
            mem_info.push_back(std::stoi(std::regex_replace((std::string) matches[0], (std::regex) "[^0-9]", "")));
    }
    
    fin.close();
    
    int memtotal = mem_info[0], memused = memtotal;
    
    for (unsigned i = mem_info.size(); i > 0; --i) {
        memused -= mem_info[i];
    }
    
	return {memused >> 10, memtotal >> 10};
}

int get_volume() {
    long vol, min, max;
    snd_mixer_t *handle;    
    snd_mixer_selem_id_t *id;
    
    snd_mixer_selem_id_alloca(&id);
    snd_mixer_open(&handle, 0);
    snd_mixer_attach(handle, "default");
    snd_mixer_selem_register(handle, NULL, NULL);
    snd_mixer_load(handle);
    
    snd_mixer_selem_id_set_index(id, 0);
    snd_mixer_selem_id_set_name(id, "Master");
    snd_mixer_elem_t *elem = snd_mixer_find_selem(handle, id);
    
    snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
    snd_mixer_selem_get_playback_volume(elem, SND_MIXER_SCHN_MONO, &vol);
    
    snd_mixer_close(handle);

    int range = max - min;
    vol -= min;
    
    return rint((double)vol / (double)range * 100);
}

static size_t write_data(void *buf, size_t size, size_t nmemb, void *userp) {
    ((std::string *) userp)->append((char *) buf, size * nmemb);
    return size * nmemb;
}

std::string get_kernel() {
    struct utsname info;
    uname(&info);
    
    std::string latest, current = info.release;

    CURL *handle = curl_easy_init();
    curl_easy_setopt(handle, CURLOPT_URL, "https://www.kernel.org/");
    curl_easy_setopt(handle, CURLOPT_WRITEFUNCTION, write_data);
    curl_easy_setopt(handle, CURLOPT_WRITEDATA, &latest);
    
    if(curl_easy_perform(handle) != 0)
        latest = "NONE";
    
    curl_easy_cleanup(handle);
    
    std::smatch matches;
    if(std::regex_search(latest, matches, (std::regex) "stable.*?\n.*\n"))
        latest = std::regex_replace((std::string) matches[0], (std::regex) "[^0-9.]", "");

    if (latest == current)
        return current;
    else
        return latest + " -> " + current;
}

int get_temp() {
    std::ifstream fin ("/sys/devices/platform/coretemp.0/hwmon/hwmon0/temp2_input", std::ifstream::in);
    
    int temp;
    fin >> temp;
    
    fin.close();
    
    return temp/1000;
}

int main() {
    std::vector<int> mem = get_mem();
    printf("%i°C  ::  %iMi / %.1fGi  ::  %d  ::  %s  ::  %i%%  ::  %s\n",
    get_temp(), mem[0], (float) mem[1]/1024, get_npkgs(), get_kernel().c_str(), get_volume(), get_date().c_str());
    
    return 0;
}
