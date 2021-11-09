/* 
 * Example showing pipeline modularizaion 
 * Using Nextfloq DSL2
 * 
 * Author: Paolo Di Tommaso 
 */ 
nextflow.preview.dsl=2

/* 
 * pipeline input parameters 
 */
params.reads = "/opt/rnaseq/data/ggal/gut_{1,2}.fq"
params.transcript = "/opt/rnaseq/data/ggal/transcriptome.fa"
params.multiqc = "/opt/rnaseq/multiqc"
params.outdir = "/opt/rnaseq/results"

log.info """\
         R N A S E Q - N F   P I P E L I N E    
         ===================================
         transcriptome: ${params.transcript}
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()

 
include { rnaseqFlow } from './rnaseq-flow.nf'

workflow {
    read_pairs_ch = Channel .fromFilePairs( params.reads, checkIfExists:true )
    rnaseqFlow( params.transcript, read_pairs_ch )
}

