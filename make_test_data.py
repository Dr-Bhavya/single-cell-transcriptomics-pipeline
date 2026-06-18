#!/usr/bin/env python3
import numpy as np
import anndata as ad
import os

def generate_mock_sc_data():
    print("Generating low-memory single-cell test matrix...")
    
    # Create 10 cells across 20 genes using a Poisson distribution
    counts = np.random.poisson(lam=5, size=(10, 20))
    adata = ad.AnnData(counts)
    
    # Ensure the output directory exists
    os.makedirs('data', exist_ok=True)
    
    # Save the compressed matrix file
    output_path = 'data/tiny_matrix.h5ad'
    adata.write(output_path)
    print(f"Success! Saved valid h5ad single-cell file to: {output_path}")

if __name__ == "__main__":
    generate_mock_sc_data()
