/*
 * Generate BAM index file
 */

include { SAMTOOLS_INDEX} from '/homes/mkumar/practice/modules/local/samtools/index/main.nf'
include { GATK_HAPLOTYPECALLER} from '/homes/mkumar/practice/modules/local/gatk/haplotypecaller/main.nf'
include { GATK_JOINTGENOTYPING} from '/homes/mkumar/practice/modules/local/gatk/jointgenotyping/main.nf'


workflow {

    // Create input channel
    reads_ch = Channel.fromPath(params.reads_bam)    //.splitText(for text file)
                      .splitCsv(header: true)
                      .map{row ->[row.id, file(row.reads_bam)]}
    // Create index file for input BAM file
    SAMTOOLS_INDEX(reads_ch)

    // Call variants from the indexed BAM file
    GATK_HAPLOTYPECALLER(
        SAMTOOLS_INDEX.out,
        params.genome_reference,
        params.genome_reference_index,
        params.genome_reference_dict,
        params.calling_intervals
    )

    //create a sample map of the output GVCFs
    sample_map = GATK_HAPLOTYPECALLER.out.collectFile() {id, gvcf, idx ->
    ["${params.cohort_name}_map.tsv", "${id}\t${gvcf}\t${idx}\n"]
    }

    // Consolidate GVCFs and apply joint genotyping analysis
    GATK_JOINTGENOTYPING(
        sample_map, 
        params.cohort_name, 
        params.genome_reference,
        params.genome_reference_index,
        params.genome_reference_dict,
        params.calling_intervals
    )
}