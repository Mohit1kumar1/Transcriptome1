#!/bin/bash -ue
samtools \
    view \
    --threads 3 \
    -c -F 260 \
    M_D_KF_010_subset_T1_mapped.bam > M_D_KF_010_subset_T1_mapped.bam.log

cat <<-END_VERSIONS > versions.yml
"SAMTOOLS_VIEW":
    samtools: $(echo $(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*$//')
END_VERSIONS
