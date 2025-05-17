# Nextflow Pipeline for Metatranscriptomic Data Processing

This repository contains a modular Nextflow pipeline developed during my internship at the Department of Algorithmische Bioinformatik, JLU. The pipeline is designed for processing metatranscriptomic short read datasets from human-derived samples, enabling accurate microbial gene expression profiling in gut microbiome samples.

## Disclaimer

This is a simplified representation of the workflow which showcases my work on the actual workflow during my internship. The complete workflow is hosted in a private repository due to permission restrictions.

## Overview

This pipeline implements a progressive filtering approach for metatranscriptomic data processing:

* **Host Sequence Removal**: Sequential filtering of human genomic, transcriptomic, and pangenomic sequences using multiple alignment tools:
  * **STAR**: Alignment against reference genomes (GRCh38 and T2T-CHM13)
  * **Bowtie2**: Additional host sequence filtering
  * **VG**: Pangenomic sequence alignment
* **rRNA Depletion**: Using SortMeRNA to remove ribosomal RNA sequences
* **Read Repair**: Final step to restore paired-end structure ensuring data integrity
* **Quality Assessment**: Integration of FASTQC and MultiQC for comprehensive quality control
* **Visualization**: Custom R scripts for aggregating and visualizing filtering metrics

This systematic approach produces high-quality microbial RNA datasets specifically designed for downstream taxonomic profiling and functional analysis.

## Pipeline Architecture

* **Modules**: Each bioinformatics tool (STAR, Bowtie2, VG, SortMeRNA) is implemented as separate modular scripts with multiple processes (e.g., alignment, filtering, metrics collection)
* **Subworkflows**: Tool-specific processes are integrated into subworkflows for efficient execution and management
* **Master Workflow**: Coordinates all subworkflows with proper dependencies and data flow
* **Configuration System**: Supports nf-core igenomes with predefined references while accommodating custom references through configurable parameters

## Key Features

* **Operators Folder**: Contains Nextflow scripts that:
  * Collect log files from each bioinformatics tool
  * Filter and extract relevant metrics
  * Aggregate and process logs into a cohesive format for visualization
  * Generate comprehensive filtering reports

* **Containerization**: Complete workflow containerized using:
  * Singularity for HPC deployment
  * Docker with versioned containers tagged and deployed via GitHub

* **HPC Integration**: Optimized for SLURM-managed high-performance computing environments

* **Data Management**:
  * Secure remote access and data transfer via SSH
  * Structured output organization for downstream analysis

## Usage

This repository can serve as:
* A learning resource for managing and processing log files in complex bioinformatics workflows
* A template for implementing progressive filtering approaches in NGS data analysis
* A foundation for developing reproducible workflows with proper containerization

## Technical Competencies Demonstrated

* NGS file format handling (FASTQ, BAM, GTF, BED)
* Pipeline optimization techniques
* Privacy-aware bioinformatics practices for human-derived samples
* Data visualization and quality assessment
* Workflow containerization and reproducibility
