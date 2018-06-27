This protocol will guild you with the de novo assembly by Hi-C tech, which is the 2 of 2 step.

***

The command line to run 3d-dna is super easy!
```
bash /home/zkzhou/software/3d-dna/run-pipeline.sh \
-m haploid \
-t 15000 \
-s 5 \
-c 15 \
/home/zkzhou/index/pilon_p.fasta \
/home/zkzhou/index/3g.mnd.txt
```
You just need to change the following five parameters:
* -t is the threshold for contig/scaffold picking
* -s is the iterative number, the more iteration you make, the more accurate and time-consuming it might be. 7-9 is big enough.
* -c is the expected chromosome number
* /PATH/TO/YOUR/RAW/FASTA
* /PATH/TO/THE/MND/FILE/GENERATED/BY/JUICER

***

:volcano:**NOTICE**:volcano:
1. For bird, the existence of microchromosomes make the _de novo_ genome assembly to be tougher and trickier. Because you will find that larger chromosomes can be assembled easily. BUT microchromosomes will mix with each other and be merged into some pseudo-large-chromosomes.
Therefore, you really need to play with **3d-dna** by your intelligence. Here is some tips you can take.
2. the \*.mnd.txt file looks like this:
```
0 tig00000003_pilon_pilon 36 0 16 tig00000003_pilon_pilon 225 1 37 50M ATTAAAAGCAAGAAAAGAACAGAACAGCAGAGAGAAGGGAGAAGGAAAGG 37 50M TGCTCTGTGGCCGCCCAGTCCCGGTCCCTGTCCCCGTCCCGTTCCCGATC E00509:81:HF7YCALXX:7:1220:14692:18045/1 E00509:81:HF7YCALXX:7:1220:14692:18045/2
```
3. actually, **WHAT YOU SHOULD KNOW IS THAT** the **\*.mnd.txt** file you get from the **juicer**, for example,
