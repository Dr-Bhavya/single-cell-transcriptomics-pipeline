nextflow.enable.dsl=2

// Pipeline parameter targets tracking inputs, scripts, and local data routing
params.input_matrix = "data/tiny_matrix.h5ad"
params.outdir       = "local_results/"
params.r_script     = "${baseDir}/run_seurat_analysis.R"

process SEURAT_MODULAR_ANALYSIS {
    container 'seurat-spatial:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    path input_file
    path r_script

    output:
    path "qc_mitochondrial_plot.png"
    path "cluster_deg_markers.csv"
    path "seurat_final_object.rds"

    script:
    """
    Rscript \${r_script}
    """
}

workflow {
    input_ch = channel.fromPath(params.input_matrix)
    script_ch = channel.fromPath(params.r_script)
    
    // Launching the analytical step passing both file pathways cleanly
    SEURAT_MODULAR_ANALYSIS(input_ch, script_ch)
}
