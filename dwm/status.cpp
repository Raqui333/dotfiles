// C Includes
#include <ctime>
#include <curl/curl.h>
#include <sys/utsname.h>

// C++ Includes
#include <iostream>
#include <regex>
#include <fstream>

#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;

// Compilation Reference
// clang++ status.cpp -lstdc++fs -std=c++17 -lcurl -o status

std::string get_date() {
    time_t tm = time(NULL);
    char date_time[32];
    
    std::strftime(date_time, sizeof(date_time), "%b %d, %a %I:%M %P", std::localtime(&tm));
    
    return static_cast<std::string>(date_time);
}

int get_npkgs() {
    unsigned int number_of_pkgs = 0;
    
    for (auto& dir : fs::directory_iterator("/var/db/pkg"))
        for (auto& pkgs : fs::directory_iterator(dir))
            number_of_pkgs++;
   
    return number_of_pkgs;
}

static size_t write_data(void *buf, size_t size, size_t nmemb, void *userp) {
    static_cast<std::string*>(userp)->append(static_cast<char*>(buf), size * nmemb);
    return size * nmemb;
}

std::string get_kernel() {
    struct utsname info;
    uname(&info);
    
    std::string latest, current = info.release;

    curl_global_init(CURL_GLOBAL_ALL);
    CURL *handle = curl_easy_init();
    
    curl_easy_setopt(handle, CURLOPT_URL, "https://www.kernel.org/");
    curl_easy_setopt(handle, CURLOPT_WRITEFUNCTION, write_data);
    curl_easy_setopt(handle, CURLOPT_WRITEDATA, &latest);
    
    if(curl_easy_perform(handle) != 0)
        latest = "NONE";
    
    curl_easy_cleanup(handle);
    curl_global_cleanup();
    
    std::smatch matches;
    if(std::regex_search(latest, matches, (std::regex) "<.*?latest_link.*?\n.*\n"))
        latest = std::regex_replace((std::string) matches[0], (std::regex) "<.*?>|\n|\\s", "");

    if (latest == current)
        return current;
    else
        return latest + " <- " + current;
}

int get_temp() {
    std::ifstream fin ("/sys/class/hwmon/hwmon0/temp2_input", std::ifstream::in);
    
    int temp;
    fin >> temp;
    
    fin.close();
    
    return temp/1000;
}

// Class MemInfo
class MemInfo {
    float mem_total;
    int mem_used;
public:
    MemInfo();
    int used() const;
    float total() const;
};

// Class MemInfo Functions
MemInfo::MemInfo() {
    std::smatch matches;
    std::vector<int> mem_info;
    
    std::ifstream fin ("/proc/meminfo", std::ifstream::in);
    
    std::string data;
    while (std::getline(fin, data)) {
        if (std::regex_match(data, matches, static_cast<std::regex>("^(MemTotal|MemFree|Buffers|Cached|Slab):.*")))
            mem_info.push_back(std::stoi(std::regex_replace(static_cast<std::string>(matches[0]), static_cast<std::regex>("[^0-9]"), "")));
    }
    
    fin.close();
    
    mem_total = mem_info[0], mem_used = mem_total;
    
    for (unsigned i = mem_info.size(); i > 0; --i)
        mem_used -= mem_info[i];
}

int MemInfo::used() const { return mem_used / 1024; }
float MemInfo::total() const { return mem_total / 1024 / 1024; }

int main() {
    MemInfo mem;

    printf("     %i°C  ::  %iMi / %.1fGi  ::  %d  ::  %s  ::  %s\n",
    get_temp(), mem.used(), mem.total(), get_npkgs(), get_kernel().c_str(), get_date().c_str());

    return 0;
}
