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
...
0 tig0000003_pilon_pilon 8204 21 16 tig00000013_pilon_pilon 8426 21 23 50M CTGGCTGCGAAGCGGGGCGAGCATCCCGTTAGCCAGGGCGAGTCCCGAAG 37 50M CCTTCTAGCCTCAGACACACATTTGGGAGAGGCAGGAGAGGAGCCCCCGC E00509:81:HF7YCALXX:5:1215:20232:57882/2 E00509:81:HF7YCALXX:5:1215:20232:57882/1
...
```

the file tells you that tig00000003_pilon_pilon and tig00000013_pilon_pilon must interact with each other within one unkown chromosome. (This unkonwn chromosomes may be larger chromosomes, or mocrochromosomes. It doesn't matter! :confetti_ball:)

WHAT YOU NEED TO DO NEXT IS TO SEPARATE

* your raw fasta into two files (one contains all the contigs that belongs to the larger chromosomes and the contigs assembled into microchromosomes are included with the other file)
* your \*.mnd.txt file into two files (same with the above)

and run 3d-dna separately.
