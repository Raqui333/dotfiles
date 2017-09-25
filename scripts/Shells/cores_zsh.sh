#!/bin/zsh

for i in {1..255};do
	printf "%03i " $i
	print -P "%K{$i} COLOR %k"
done | sed 'N;N;N;N;s/\n//g'
