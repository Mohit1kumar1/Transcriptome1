nextflow.enable.dsl=2

params.output_file = 'VG.txt'
include{PROCESS_LOG_FILES} from "./star.nf"
include{SAMTOOLS_VIEW} from "/homes/mkumar/practice/modules/local/samtools/view/main.nf"
process VG_LOG_FILES {
    input:
    val ids
    path log_files

    output:
    path(params.output_file)

    script:
    """
    
    Rscript /homes/mkumar/practice/src/vg.r ${ids.join(" ")} ${log_files.join(" ")} ${params.output_file}
    """
}

 workflow{
    vg_log_files = Channel.of(["id":"M_D_KF_010"])
.combine(Channel.fromPath("/homes/mkumar/practice/vg_example_files/M_D_KF_010_subset_T1_mapped.bam"))
.concat(Channel.of(["id":"M_D_PF_009a"])
 .combine(Channel.fromPath("/homes/mkumar/practice/vg_example_files/M_D_PF_009a_subset_T1_mapped.bam")))
.concat(Channel.of(["id":"M_D_PF_011a"])
 .combine(Channel.fromPath("/homes/mkumar/practice/vg_example_files/M_D_PF_011a_subset_T1_mapped.bam")))

SAMTOOLS_VIEW(vg_log_files)

SAMTOOLS_VIEW.out.log_files
                   .flatten()
                   .branch {
                    ids: it instanceof Map
                    log_files: it instanceof Path
                    }
               .set { result }


result.ids.map{it.id}.view { "$it is small" }
result.log_files.view { "$it is large" }

VG_LOG_FILES(result.ids.map{it.id}.collect(), result.log_files.collect())
//PROCESS_LOG_FILES(bowtie_log_files.collect())
}
