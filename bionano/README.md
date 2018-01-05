# _de novo_ genome assembly by bionano data
Recently, a newly sequencing technique becomes much more popular among _de novo_ genome assembly research, optical map, which could greatly improve the length of scaffold. You could read the _nature biotechnology_ paper ([Genome mapping on nanochannel arrays for structural variation analysis and sequence assembly](https://www.nature.com/articles/nbt.2303)) for more details about the nanochannel array technique.
You will get **.bnx** files for future analysis and there are mainly three softwares, [Bionano Genomics IrysView software](https://bionanogenomics.com/support-page/irysview/), [KSU scripts](https://github.com/i5K-KINBRE-script-share/Irys-scaffolding) and [runBNG](https://github.com/AppliedBioinformatics/runBNG). I have tried all these three softwares and greatly prefer the runBNG software. 
* **Bionano Genomics IrysView** supports **Windows OS 64-bit systems** only, and you could also explore the protocol and guide by its [website](https://bionanogenomics.com/support-page/irysview/) which provides the practice samples, learning PDFs and videos.
* **KSU scripts** provide three pipelines: 
  * [Sewing Machine pipeline: iteratively super scaffold genome FASTA files with BioNano genome maps using stitch.pl](https://github.com/i5K-KINBRE-script-share/Irys-scaffolding/blob/master/KSU_bioinfo_lab/stitch/sewing_machine_LAB.md)
  * ["Raw data-to-finished assembly and assembly analysis" pipeline for BioNano molecule maps with a sequence-based genome FASTA](https://github.com/i5K-KINBRE-script-share/Irys-scaffolding/blob/master/KSU_bioinfo_lab/assemble_XeonPhi/assemble_XeonPhi_LAB.md)
  * ["Raw data-to-finished de novo assembly and assembly analysis" pipeline for BioNano molecule maps](https://github.com/i5K-KINBRE-script-share/Irys-scaffolding/blob/master/KSU_bioinfo_lab/assemble_XeonPhi/assemble_XeonPhi_de_novo_LAB.md)
* **runBNG** protocol will be showed as follow (please satisfy the [**dependencies of runBNG**](https://github.com/AppliedBioinformatics/runBNG#dependencies), the perl version should be v5.10.x, v5.14.x or v5.16.x)

## runBNG
***
* STEP1: runBNG fa2cmap
  ```
  Description: in silico digest .fasta file into .cmap file using particular enzyme.
  ```
  **Notice**: 
    * you need to make a output directory to store your runBNG results
    * set `runBNG` as executable shell: `chmod` `+x` `/home/zl/runBNG/runBNG`
    * quickly call runBNG: `alias` `runBNG='/home/zl/runBNG/runBNG'`
  example: `runBNG` `fa2cmap` `-f` `/home/zl/bionano/pilon_p.fasta` `-o` `/home/zl/bionano/output` `-e` `BspQI` `-s` `/home/zl/scripts`
  
  you will get the following two files:
  * `/home/zl/bionano/output/fa2cmap/pilon_p_BspQI_20Kb_5labels.cmap`
  * `/home/zl/bionano/output/fa2cmap/pilon_p_BspQI_20Kb_5labels_key.txt`
***
* STEP2: runBNG cmapstats
  ```
  Description: Get statistic analysis from the .cmap file
  ```
  example: `runBNG` `cmapstats` `-c` `/home/zl/bionano/output/fa2cmap/pilon_p_BspQI_20Kb_5labels.cmap` `-s` `/home/zl/scripts`
  
  you will get the following information printed on screen:
  ```
  ## Start date: Thu Dec 28 00:12:16 UTC 2017
  ## The cmap file is: /home/zl/bionano/output/fa2cmap/pilon_p_BspQI_20Kb_5labels.cmap
  ## The path to BioNano scripts folder is: /home/zl/scripts
  Stats of the cmap file:
  Count  = 1881
  Min length (Mb) = 0.02
  Median length (Mb) = 0.067
  Mean length (Mb) = 0.604
  N50 length (Mb) = 4.199
  Max length (Mb) = 19.837
  Total length (Mb) = 1136.310
  Label density (/100Kb) = 19.870
  ## End date: Thu Dec 28 00:12:16 UTC 2017
  ```  
***  
* STEP3: runBNG bnxmerge
  ```
  Description: Usually, you will have more than one .bnx file so you can merge all of your .bnx files into a merged_molecule.bnx file
  ```
  example: `runBNG` `bnxmerge` `-l` `/home/zl/bionano/list` `-t` `8` `-m` `30` `-p` `merged_Molecule` `-o` `/home/zl/bionano/output/bnxmerge` `-r` `/home/zl/tools/RefAligner`
  
  the `/home/zl/bionano/list` of `-l` contains the absolute path of the to be merged .bnx files, for example
  ```
  /home/zl/bionano/PK1/Molecules.bnx
  /home/zl/bionano/PK2/Molecules.bnx
  ```
  
  you will get the following three files:
  * `/home/zl/bionano/output/bnxmerge/merge_stats.txt`
  * `/home/zl/bionano/output/bnxmerge/merge_Molecules.bnx`
  * `/home/zl/bionano/output/bnxmerge/merge_Molecules.idmap`
  * `/home/zl/bionano/output/bnxmerge/merge_Molecules.stdout`
***
* STEP4: runBNG bnxstats
  ```
  Description: Get statistic analysis from the .bnx file
  ```
  example: `runBNG` `bnxstats` `-b` `/home/zl/bionano/output/merged_Molecules.bnx` `-p` `bnxstats_table` `-o` `/home/zl/bionano/output/bnxstats`
  
  you will get the following one file:
  * `/home/zl/bionano/output/bnxstats/bnxstats_table.txt`
  
  you will also see these printed on your screen:
  ```
  Length  AvgIntensity    SNR     NumberofLabels
  605702.00       0.06    11.74   86
  152952.00       0.04    9.45    23
  180103.70       0.03    3.95    28
  185088.90       0.04    21.17   23
  160710.20       0.04    5.68    23
  256580.50       0.04    7.31    39
  ## Start date: Thu Dec 28 03:37:28 UTC 2017
  ## The checked bnx file is: /home/zl2202/bionano/output/merged_molecule.bnx
  ## Name for the saved table: bnxstats_table.txt
  ## Output directory is: /home/zl2202/bionano/output
  Stats of molecules in the input bnx file:
  Number of molecules is: 1025496
  Total length of those molecules is (Mb): 299067
  The length N50 is (Kb): 307.566
  Minimum length of those molecules is (Kb): 150.037
  Maximum length of those molecules is (Kb): 2889.47
  Average length of those molecules is (kb): 291.632
  Length standard deviation is (Kb): 152.202
  Total number of labels is: 37835521
  Label density is (/100Kb): 12.6512
  Maximum signal noise ratio (SNR) is: 10000.00
  Minimum signal noise ratio (SNR) is: 0.04
  Average signal noise ratio (SNR) is: 9.30934
  Maximum avgIntensity is: 0.02
  Minimum avgIntensity is: 0.99
  Average avgIntensity is: 0.0714828
  ## End date: Thu Dec 28 03:37:28 UTC 2017
  ```
***
* STEP5: runBNG bnxfilter
  ```
  Description: Filter unqualified molecule maps and get a new bnx file
  ```
  example: `runBNG` `bnxfilter` `-b` `/home/zl/bionano/output/bnxmerge/merged_Molecules.bnx` `-t` `8` `-m` `30`  `-p` `filter_merge_Molecules` `-o` `/home/zl/bionano/output/bnxfilter` `-r` `/home/zl/tools/RefAligner`
  
  you will get the following three files:
  * `/home/zl/bionano/output/bnxfilter/filtered_stats.txt`
  * `/home/zl/bionano/output/bnxfilter/filter_merge_Molecule.bnx`
  * `/home/zl/bionano/output/bnxfilter/filter_merge_Molecule.stdout`
***
* STEP6: runBNG MQR
  ```
  Description: Report the helpful stats of given BioNano single molecules for the coming de novo assemble step
  ```
  example: `runBNG` `MQR` `-b` `/home/zl/bionano/output/merged_Molecules.bnx` `-r` `/home/zl/bionano/output/fa2cmap/pilon_p_BspQI_20Kb_5labels.cmap` `-z` `1136` `-R` `/home/zl/tools/RefAligner` `-t` `8` `-m` `30` `-o` `/home/zl/bionano/output` `-p` `MQR`
  
  you will get the following 12 files:
  * `/home/zl/bionano/output/MQR_r.cmap`
  * `/home/zl/bionano/output/MQR.map`
  * `/home/zl/bionano/output/MQR_q.cmap`
  * `/home/zl/bionano/output/MQR.xmap`
  * `/home/zl/bionano/output/MQR_intervals.txt`
  * `/home/zl/bionano/output/MQR.scan`
  * `/home/zl/bionano/output/MQR.err`
  * `/home/zl/bionano/output/MQR.maprate`
  * `/home/zl/bionano/output/MQR.errbias`
  * `/home/zl/bionano/output/MQR.errbin`
  * `/home/zl/bionano/output/MQR_rescaled.bnx`
  * `/home/zl/bionano/output/MQR.stdout`
  
  you will also get the stats printed on your screen:
  ```
  False Positive Density (/100Kb) [FP]: 1.27
  False Positive (%/100): 0.07
  False Negative Rate (%/100) [FN]: 0.1
  ScalingSD (Kb^1/2) [sd]: -0.02
  SiteSD (Kb) [sf]: 0.2
  RelativeSD [sr]: 0.04
  BPP: 485.68
  N Molecules Mapped to Reference: 5000
  Map Rate (%/100): 69.88
  ```
***
* STEP7: runBNG denovo
  ```
  Description: De novo assembly for BioNano single molecules
  ```
  **Notice**: 
   althoght `-p` `-n` `-d` `-f` and `-R` are optional parameters, you can acquire those argumens during the last MQR step. Actually, the default values are close to my own results.

   |parameters|            meaning            |default|my data|abs diff|
   |:--------:|:-----------------------------:|:-----:|:-----:|:------:|
   |    -p    |flase positive density (/100Kb)|1.5    |1.23   |0.27    |
   |    -n    |  false negative rate (%/100)  |0.15   |0.09   |0.06    |
   |    -d    |       scalingSD (Kb^1/2)      |0      |0.03   |0.03    |
   |    -f    |          siteSD (Kb)          |0.02   |0.20   |0.18    |
   |    -R    |          relativeSD           |0.03   |0.04   |0.01    |

  example: `runBNG` `denovo` `-t` `/home/zl/tools/` `-s` `/home/zl/scripts/` `-b` `/home/zl/bionano/output/bnxfilter/filter_merge_Molecules.bnx` `-T` `8` `-j` `2` `-r` `/home/zl/bionano/output/fa2cmap/pilon_p_BspQI_20Kb_5labels.cmap` **`-p`** `1.23` **`-n`** `0.09` **`-d`** `0.03` **`-f`** `0.2` **`-R`** `0.04` `-o` `/home/zl/bionano/output/hybrid`
  
  **Notice**:
  This step may take over 5 days to be completed becasue totally 26 stages will be executed. So keep power on ;-)
  
  you will get the following files in the output directory (completed states):
  * `/home/zl2202/bionano/output/denovo/exp_optArguments.xml`
  * `/home/zl2202/bionano/output/denovo/all.bnx`
  * `/home/zl2202/bionano/output/denovo/molecule_stats.txt`
  * `/home/zl2202/bionano/output/denovo/all_sorted.bnx`
  * `/home/zl2202/bionano/output/denovo/all_sorted.stdout`
  * `/home/zl2202/bionano/output/denovo/all_1_of_8.bnx`
  * `/home/zl2202/bionano/output/denovo/all_2_of_8.bnx`
  * `/home/zl2202/bionano/output/denovo/all_3_of_8.bnx`
  * `/home/zl2202/bionano/output/denovo/all_4_of_8.bnx`
  * `/home/zl2202/bionano/output/denovo/all_5_of_8.bnx`
  * `/home/zl2202/bionano/output/denovo/all_6_of_8.bnx`
  * `/home/zl2202/bionano/output/denovo/all_7_of_8.bnx`
  * `/home/zl2202/bionano/output/denovo/all_8_of_8.bnx`
  * `/home/zl2202/bionano/output/denovo/all.stdout`
  * `/home/zl2202/bionano/output/denovo/all.list`
  * `/home/zl2202/bionano/output/denovo/exp_informaticsReport.txt`
  * `/home/zl2202/bionano/output/denovo/status.xml`
  * `/home/zl2202/bionano/output/denovo/memory_log.txt`
  * `/home/zl2202/bionano/output/denovo/exp_pipelineReport.txt`
  
  you will also get the following three directories:
  * `/home/zl2202/bionano/output/denovo/ref (with one file in)`
  * `/home/zl2202/bionano/output/denovo/align (with 109 files in)`
  * `/home/zl2202/bionano/output/denovo/contigs (with 899 files and 43 subdirectories in)`
  
  **_ATTENTION:
  Only the file `/home/zl2202/bionano/output/denovo/contigs/exp_refineFinal1/EXP_REFINEFINAL1.cmap` is needed to make future hybrid (generating new fasta file) process._**
  
***
* STEP8: runBNG hybrid
  ```
  Description: Generating new fasta flie improved by optical map
  ```  
  example: `runBNG` `hybrid` `-t` `/home/zl2202/tools/` `-s` `/home/zl2202/scripts/` `-b` `/home/zl2202/bionano/output/bnxfilter/filtered_merged_Molecules.bnx` `-r` `/home/zl2202/bionano/pilon_p.fasta` `-e` `BspQI` `-z` `1136` `-f` `/home/zl2202/bionano/output/denovo/contigs/exp_refineFinal1/EXP_REFINEFINAL1.cmap` `-o` `/home/zl2202/bionano/output/hybrid` `-T` `8` `-M` `32` `-B` `2` `-N` `2` 
  
  you will get the following one file in the output directory:
  * `cur_results.txt`
  
  you will get 11 folders in the hybrid directory:
  * `/home/zl2202/bionano/output/hybrid/fa2cmap`
  * `/home/zl2202/bionano/output/hybrid/align0`
  * `/home/zl2202/bionano/output/hybrid/align1`
  * `/home/zl2202/bionano/output/hybrid/assignAlignType`
  * `/home/zl2202/bionano/output/hybrid/mergeNGS_BN`
  * `/home/zl2202/bionano/output/hybrid/agp_fasta`
  * `/home/zl2202/bionano/output/hybrid/align_final`
  * `/home/zl2202/bionano/output/hybrid/hybrid_scaffolds`
  * `/home/zl2202/bionano/output/hybrid/alignmol_bionano`
  * `/home/zl2202/bionano/output/hybrid/alignmol_hybrid`
  * `/home/zl2202/bionano/output/hybrid/auto_noise`
  
  ```
  cd /home/zl2202/bionano/output/hybrid/agp_fasta
  ls -rtl 
  .
  ├── EXP_REFINEFINAL1_bppAdjust_cmap_Test_fa_NGScontigs_HYBRID_SCAFFOLD.agp
  ├── EXP_REFINEFINAL1_bppAdjust_cmap_Test_fa_NGScontigs_HYBRID_SCAFFOLD.fasta
  ├── EXP_REFINEFINAL1_bppAdjust_cmap_Test_fa_NGScontigs_HYBRID_SCAFFOLD.gap
  ├── EXP_REFINEFINAL1_bppAdjust_cmap_Test_fa_NGScontigs_HYBRID_SCAFFOLD_NOT_SCAFFOLDED.fasta
  ├── EXP_REFINEFINAL1_bppAdjust_cmap_Test_fa_NGScontigs_HYBRID_SCAFFOLD_trimHeadTailGap.coord
  ├── EXP_REFINEFINAL1_bppAdjust_cmap_Test_fa_NGScontigs_HYBRID_SCAFFOLD.xmap_sorted.xmap
  ├── Test_BSPQI_20kb_5labels_key.txt.cutted.txt
  ├── Test.fa.cutted.fasta
  ├── xmap2agp.errlog
  └── xmap2agp.log
  ```
  
  **_In the hybrid_scaffolds folder, you are expected to use the /*_HYBRID_SCAFFOLD.fasta file and the /*_HYBRID_SCAFFOLD_NOT_SCAFFOLDED.fasta file. You may merge them together._** 
  
  **_For more information, please check the /*_NGScontigs_HYBRID_SCAFFOLD.agp file and you will know which scaffolds have been stitched and vice versa._**
  
  
## Congratulations! You have get the new fasta flie improved by optical map!!!

Please cite [Andy Yuan's paper: **runBNG: a software package for BioNano genomic analysis on the command line**](https://academic.oup.com/bioinformatics/article/33/19/3107/3865779) if you `runBNG` ;-)
