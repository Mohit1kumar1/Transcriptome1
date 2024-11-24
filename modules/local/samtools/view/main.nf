process SAMTOOLS_VIEW {
    tag "$meta.id"
    label 'process_low'

    conda "bioconda::samtools=1.17"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
     'https://depot.galaxyproject.org/singularity/samtools:1.17--h00cdaf9_0' :
     'biocontainers/samtools:1.17--h00cdaf9_0' }"

    input:
    tuple val(meta), path(input)

    output:
    tuple val(meta), path("*.log"),   emit: log_files
    path  "versions.yml",             emit: versions

    when:
    task.ext.when == null || task.ext.when
    script:
    """
    samtools \\
        view \\
        --threads ${task.cpus-1} \\
        -c -F 260 \\
        $input > ${input}.log

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
    END_VERSIONS
    """

    stub: // for testing purpose 
    def prefix = task.ext.prefix ?: "${meta.id}"
    """

    cat <<-END_VERSIONS > versions.yml //no idea
    "${task.process}":
        samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
    END_VERSIONS
    """ 
}

