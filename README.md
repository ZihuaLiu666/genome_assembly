# genome_assembly

A customized 3D genome *de novo* assembly protocol based on the powerful tools designed by [Aiden Lab](https://github.com/theaidenlab). Two softwares are employed, [1] [juicer](https://github.com/theaidenlab/juicer) and [2] [3d-dna](https://github.com/theaidenlab/3d-dna), to complete the *de novo* assembly project. Althogh there are comprehensive descriptions about the two tools, some problems may occur when you are preparing the input files and the single computing node executing the the scripts. We devote to simplify the computing progress, therefore this customized protocol is extremely friendly to naive operators who is not very familiar to bioinformatics.

### Why juicer and 3d-dna?
3d-dna is an amazing tool, which can correct the misassembly of the initial draft assembly to end-to-end assembly by iterative scaffording and overlap merging (more details are shown in the paper: [De novo assembly of the Aedes aegypti genome using Hi-C yields chromosome-length scaffolds](http://science.sciencemag.org/content/early/2017/03/22/science.aal3327.full)). The juicer is used for creating merged and deduplicated genome files (* .merged_nodups.txt) which is one of the input files for 3d-dna, also it is called one-click system for analyzing loop-resolution Hi-C experiments (more details are shown in the paper: [Juicer Provides a One-Click System for Analyzing Loop-Resolution Hi-C Experiments](http://www.cell.com/cell-systems/abstract/S2405-4712(16)30219-8)).

### Where is modified?
The **juicer.sh** in the juicer is modified when you are going to run it on a single CPU (**NOTICE**: The CPU version is fine for small Hi-C experiments, but any reasonably sized experiment will take an extremely long time to run and therefore should be run [on a cluster](https://github.com/theaidenlab/juicer/wiki/Running-Juicer-on-a-cluster) or [in the cloud](https://github.com/theaidenlab/juicer/wiki/Running-Juicer-on-Amazon-Web-Services)). The following is about modified information: 

* The modification is in case of the disk space pressure (one of the author told me that four times the disk space of the fastqs is essential but actually more than 10 times is needed)
* **Althogh** it will minimize your space pressure, it may also cause troubles if something wrong with your troubleshooting.
    - after ```line 420``` ```rm $name1$ext.sam``` added
    - after ```line 429``` ```rm $name2$ext.sam``` added
    - after ```line 433``` ```rm *sort.sam``` added
    - after ```line 435``` ```rm *sort1.sam``` added
    - at ```line 442``` ```rm $name1$ext*.sa* $name2$ext*.sa*``` removed
    - after ```line 449``` ```rm $name$ext.sam``` added
    - after ```line 459``` ```rm $name${ext}_norm.txt``` added
    - at ```line 479``` ```rm $name${ext}_norm.txt $name${ext}.frag.txt``` replaced
    - at ```line 479``` ```echo "(-: Nice work! Redundant files are already removed!"``` added
    - after ```line 496``` ```rm $splitdir/*.sort.txt``` added
    - after ```line 506``` ```rm ${outputdir}/merged_sort.txt``` added

### How to do?
#### Start with juicer
   * Let's firstly look into the command line of juicer: ```juicer.sh [options]```. Those options can be simplified as
        * ```-D``` ```the directory that should have scripts/, references/ and restriction_sites/```
        * ```-S``` ```choose modes (early, merge, dedup, final and postproc)```
        * ```-d``` ```the top directory```
        * ```-r``` ```use the short read version of the aligner, bwa aln```
        * ```-R``` ```2 meeans paired-end```
        * ```-z``` ```the directory of your draft genome assembly file (.fasta)```
        * ```-s``` ```MboI or HindIII```
        * ```-y``` ```the directory of your restriction site file (.bed)```
        * ```-p``` ```the directory of your chromosome sizes file (.sizes)```
