
#!/bin/bash

keywords=("C1" "C2" "C-siNC-1a-2024070239-08" "C3" "C4")
for keyword in "${keywords[@]}"
do


    stringtie ./"$keyword"/bam/"$keyword"_sort.bam -e -B -p 2 -G \
   ./GCF_002263795.3_ARS-UCD2.0_genomic.gff -o ./"$keyword"/"$keyword"/"$keyword".gtf


done
