
#!/bin/bash

keywords=("1" "2" "3" "4")
for keyword in "${keywords[@]}"
do
    hisat2 --dta -p 2 -x ./hisat2/ARS-UCD2.0 \
    -1 ./"$keyword"/clean/"$keyword"_R1_clean.fq.gz -2 ./"$keyword"/clean/"$keyword"_R2_clean.fq.gz -S ./"$keyword"/bam/"$keyword".sam > ./"$keyword"/bam/"$keyword"_hisat2.log 2>&1
    samtools view -@ 2 -bSh ./"$keyword"/bam/"$keyword".sam -o ./"$keyword"/bam/"$keyword".bam
    samtools sort -@ 2 ./"$keyword"/bam/"$keyword".bam > ./"$keyword"/bam/"$keyword"_sort.bam
done
