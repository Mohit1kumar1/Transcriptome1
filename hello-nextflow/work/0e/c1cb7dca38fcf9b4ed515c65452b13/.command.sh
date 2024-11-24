#!/bin/bash -ue
gatk GenomicsDBImport     --sample-name-map family_trio_map.tsv     --genomicsdb-workspace-path family_trio_gdb         -L intervals.list

gatk GenotypeGVCFs         -R ref.fasta         -V gendb://family_trio_gdb         -O family_trio.joint.vcf         -L intervals.list
