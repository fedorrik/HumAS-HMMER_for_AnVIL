## Hum-AS-HMMER for AnVIL

This is a modified version of [HumAS-HMMER](https://github.com/enigene/HumAS-HMMER). Everything you need to produce ASat annotation standart pack (except [StV](https://github.com/fedorrik/stv) script) are in this repo.

Usage: 
```
./hmmer-run.sh input_folder AS-HORs-hmmer3.0-030922.hmm number_of_threads
./hmmer-run_SF.sh input_folder AS-SFs-hmmer3.0.290621.hmm number_of_threads
```

RECOMMENDATION: If you have fasta file with few sequeces I recommend to split them into separate files with one sequence in each. So, script will proccess each sequence separately (in a loop) which will take less storage and time. 

*In the first commit scripts hmmer-run.sh and hmmertblout2bed.awk were the same as in the [enigene](https://github.com/enigene?tab=repositories) repositories. After that, I added few changes (always adding comment which starts with # FEDOR). And I made two versions of hmmer-run.sh script.*

For each assembly we need to generate 4 bed files: AS-HOR, AS-HOR+SF, AS-strand, AS-SF.

 - AS-HOR+SF is main output of hmmer-run.sh
 - AS-HOR is obtained from AS-HOR+SF by one awk command which removes SF lines (hmmer-run.sh line 63)
 - AS-SF is main output of hmmer-run_SF.sh
 - AS-strand is obtained from AS-SF by one awk command which changes colors (hmmer-run_SF.sh line 63)

So, to get files like in the test dir, run:

    ./hmmer-run.sh test/ AS-HORs-hmmer3.0-030922.hmm 8
Output beds: AS-HOR+SF, AS-HOR

    ./hmmer-run_SF.sh test/ AS-SFs-hmmer3.0.290621.hmm 8
Output beds: AS-SF, AS-strand
