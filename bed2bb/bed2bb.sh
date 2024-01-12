#!/bin/zsh
# Converts all bed files in current directory to BigBed files
# You need to have bed files, bed2bb.sh, seqlen.py, bed4track.py, bedToBigBed in one directory
# Usage: ./bed2bb.sh <path/to/assembly>.fa

# bedToBigBed requires chrom.sizes file with length of each seqence in fasta
echo "creating chrom.sizes file"
python3 seqlen.py $1 > "chrom.sizes"

# convert all bed files in current dir to BigBed
for bed in ./*.bed
do
  # get name of file (w/o .bed extension)
  track=`echo $bed | awk '{split($0, name, "/"); print name[2]}' | awk '{split($0, name, "."); print name[1]}'`
  echo $bed
  # run python script wich takes care of scores and long names
  python3 bed4track.py $track.bed | bedtools sort > bed4track.bed
  # convert bed to BigBed
  ./bedToBigBed bed4track.bed chrom.sizes $track.bb
  rm bed4track.bed
done

