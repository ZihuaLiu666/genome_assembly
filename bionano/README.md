# _de novo_ genome assembly by bionano data
Recently, a newly sequencing technique becomes much more polular among _de novo_ genome assembly research, optical map, which could greatly improve the length of scaffold. You could read the _nature biotechnology_ paper ([Genome mapping on nanochannel arrays for structural variation analysis and sequence assembly](https://www.nature.com/articles/nbt.2303)) for more details about the nanochannel array technique.
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
  **Notice**: 
    * you need to make a output directory to store your runBNG results
    * set `runBNG` as executable shell: `chmod` `+x` `/home/zl/runBNG/runBNG`
    * quickly call runBNG: `alias` `runBNG='/home/zl/runBNG/runBNG'`
  ```
  Description: in silico digest .fasta file into .cmap file using particular enzyme.
  ```
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
  Median length (Mb) = 0.604
  Mean length (Mb) = ???
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
  example: `runBNG` `bnxmerge` `-l` `/home/zl/bionano/list` `-t` `8` `-m` `30` `-p` `merged_Molecule` `-o` `/home/zl/bionano/output` `-r` `/home/zl/tools/RefAligner`
  
  you will get the following three files:
  * `/home/zl/bionano/output/merged_stats.txt`
  * `/home/zl/bionano/output/merged_Molecules.bnx`
  * `/home/zl/bionano/output/merged_Molecules.stdout`
***
* STEP4: runBNG bnxstats

