
#!/bin/bash

keywords=("31" "32" "49" "50")
for keyword in "${keywords[@]}" 
do
    
    mkdir ./"$keyword"/trim
    mkdir ./"$keyword"/bam
    mkdir ./"$keyword"/tmp
    fastp -w 5 -i ./"$keyword"/"$keyword"_R1.fq.gz -o ./"$keyword"/clean/"$keyword"_R1_clean.fq.gz \
    -I ./"$keyword"/"$keyword"_R2.fq.gz -O ./"$keyword"/clean/"$keyword"_R2_clean.fq.gz -j ./"$keyword"/clean/"$keyword".json -h ./"$keyword"/clean/"$keyword".html


done
