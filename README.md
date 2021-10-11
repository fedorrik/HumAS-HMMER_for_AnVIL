## Hum-AS-HMMER for AnVIL

*In first commit scripts hmmer-run.sh and hmmertblout2bed.awk were the same as in the enigene repositories.*

For each assembly we need to generate 4 bed files: AS-HOR, AS-HOR+SF, AS-strand, AS-SF.

 - AS-HOR+SF is main output of hmmer-run.sh
 - AS-HOR and AS-strand get from AS-HOR+SF by one awk command
   (hmmer-run.sh lines 60 and 62)
 - AS-SF is another story. We need to run hmmer again with another hmm profiles. I made separate script hmmer-run_SF.sh which is almost identical to hmmer-run.sh:
 ``` 
    $ diff hmmer-run.sh hmmer-run_SF.sh 
    57,62c57
    <     awk "{if(!(\$0 in a)){a[\$0]; print}}" _nhmmer-t1-$bn.bed > AS-HOR+SF-vs-$bn.bed
    < 
    < #   FEDOR: AS-HOR only (skip SF monomers)
    <     awk '{ if (length($4)==2) {next} print}' AS-HOR+SF-vs-$bn.bed > AS-HOR-vs-$bn.bed
    < #   FEDOR: AS-strand annotation. "+" is blue, "-" is red
    <     awk -F $'\t' 'BEGIN {OFS = FS} {if ($6=="+") {$9="0,0,255"}; if ($6=="-") {$9="255,0,0"} print $0}' AS-HOR-vs-$bn.bed > AS-strand-vs-$bn.bed
    ---
    >     awk "{if(!(\$0 in a)){a[\$0]; print}}" _nhmmer-t1-$bn.bed > AS-SF-vs-$bn.bed
```
So, to get files like in the test dir I run:

    ./hmmer-run.sh test/ AS-HORs-hmmer3.0-170921.hmm
Output: AS-HOR+SF, AS-HOR, AS-strand

    ./hmmer-run_SF.sh test/ AS-SFs-hmmer3.0.290621.hmm
Output: AS-SF

