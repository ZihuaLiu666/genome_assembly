This protocol will guild you with the _de novo_ assembly by Hi-C tech, which is the 1 of 2 step.

## Preparation work
1. :dog2: mkdir /WHERE/YOU/WANT/TO/RUN/JUICER/ (for example, I run **juicer** at /home/zkzhou/zihua) and move into it.
```
mkdir 3g_juicer && cd 3g_juicer
```
***

2. :dog: soft link juicer script into your working directory as **scripts**
```
ln -s /home/zkzhou/software/juicer/CPU scripts
```
*** 

3. :dog2: soft link your raw fasta file into **references** subdirectory and generate some index files for BWA mapping work. For example, my original fasta file (pilon_p.fasta) is in the /home/zkzhou/index/

**NOTICE :volcano:**
I highly recommend you to write bwa index into a shell and then send it to the backgroud because bwa idnex might takes some time! :volcano:
```
mkdir references && cd references
ln -s /home/zkzhou/index/pilon_p.fasta ./
bwa index -a bwtsw pilon_p.fasta
cd ..
```
after bwa index step, you will get five index files. Totally, six files are allocated in the **references** subdirectory. (* is the prefix of your original fasta)
```
*.fasta
*.amb
*.ann
*.bwt
*.pac
*.sa
```

***

4. :dog: generate restriction file and length file of your raw fasta file

**NOTICE :volcano:**
make sure what kind of ENZYME you used! :volcano:
```
mkdir restriction_sites && cd restriction_sites
python2 /home/zkzhou/software/juicer/misc/generate_site_positions.py MboI pilon_p.fasta /home/zkzhou/index/pilon_p.fasta
<YOU MIGHT NEED TO WAIT FOR SEVERAL MINUTES...>
mv pilon_p.fasta_MboI.txt pilon_p.fasta_mboi.txt
```
the 1st args is enzyme, the 2nd is prefix and the 3rd is the location of your raw genome. I highly recommend you to do what I have done.

then, we need to generate length file *.sizes*. You can use my Python3 script.
```
python3 /home/zkzhou/software/chromosome_size_counter.py -i /home/zkzhou/index/pilon_p.fasta -o pilon_p.fasta.sizes
cd ..
```
**NOTICE**

the length file shold look like this:
```
tig00602628_pilon_pilon 24851
tig00053124_pilon_pilon 7280486
tig00053500_pilon_pilon 46772
tig00001790_pilon_pilon 15097
tig00013947_pilon_pilon 19480
```

***

5. :dog2: soft link the raw sequencing file into your **fastq** subdirectory.
```
mkdir fastq && cd fastq
ln -s /home/zkzhou/data/clean_reads/cat_muscle/muscle_R1.fastq.gz ./
ln -s /home/zkzhou/data/clean_reads/cat_muscle/muscle_R2.fastq.gz ./
cd ..
```
***

6. :dog: run juicer
```
mkdir work && cd work
vi 3g_juicer.sh
```
paste and change the following contents:
```
bash /home/zkzhou/zihua/3g.juicer/scripts/juicer.sh \ # /PATH/TO/YOUR/SCRIPTS/juicer.sh
-d /home/zkzhou/zihua/3g.juicer \ # step 1: /WHERE/YOU/WANT/TO/RUN/JUICER/
-D /home/zkzhou/zihua/3g.juicer \ # step 1: /WHERE/YOU/WANT/TO/RUN/JUICER/
-S early \ # you just want to get the *mnd.txt file, so early is ok...
-r \
-R 2 \
-z /home/zkzhou/zihua/3g.juicer/references/pilon_p.fasta \ # /PATH/TO/YOUR/RAW/FASTA/FILE
-s MboI \ #enzyme
-y /home/zkzhou/zihua/3g.juicer/restriction_sites/pilon_p.fasta_mboi.txt \ # /PATH/TO/YOUR/RESTRICTION/FILE
-p /home/zkzhou/zihua/3g.juicer/restriction_sites/pilon_p.fasta.sizes  # /PATH/TO/YOUR/LENGTH/FILE
```

***

7. :dog2: nohup bash 3g_juicer.sh 2> log.out &



**NOTICE**

1. :dog: bwa mapping is the most time-consuming step.
2. :cat: -S should be early, and then you can get your *.mnd.txt* file for the future 3d-dna software.
3. :bird: if you have any questions, please post it on the issue.
