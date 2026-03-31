import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import re

def run_unblinding(fits_csv, truth_csv, output_dir="plots"):
    """
    Merges the blind fit results with the secret truth vault and generates
    residual plots to evaluate reconstruction performance.
    """
    # --- Plotting Configuration ---
    plt.rc('font', family='serif', size=19)
    plt.rcParams['text.usetex'] = True
    plt.rcParams['mathtext.fontset'] = 'cm'
    
    # Ensure output directory exists
    os.makedirs(output_dir, exist_ok=True)

    print(f"Loading fit results from: {fits_csv}")
    print(f"Loading true values from: {truth_csv}")

    try:
        df_fits = pd.read_csv(fits_csv)
        df_truth = pd.read_csv(truth_csv)
    except FileNotFoundError as e:
        print(f"Error: {e}")
        return

    # --- Column Definitions ---
    fit_tag_col = "Data Tag"
    fit_col = "Best Fit Angle (deg)"
    err_col = "Error (deg)"
    
    truth_tag_col = "Dataset_ID"
    true_col = "True_Angle_Deg"

    # Verify columns exist before proceeding
    if fit_tag_col not in df_fits.columns or truth_tag_col not in df_truth.columns:
        print("Error: Could not find the expected columns.")
        print(f"Fits columns: {df_fits.columns.tolist()}")
        print(f"Truth columns: {df_truth.columns.tolist()}")
        return

    print(f"\nSample of Fit Tags: {df_fits[fit_tag_col].head(3).tolist()}")
    print(f"Sample of Truth Tags: {df_truth[truth_tag_col].head(3).tolist()}")

    # --- ROBUST MERGING ---
    # Instead of direct string matching, we extract the first number found in the ID columns.
    # This matches "Blind_Data_0" with "0" or "Dataset 000" with "0".
    df_fits['match_id'] = df_fits[fit_tag_col].astype(str).str.extract(r'(\d+)').astype(float)
    df_truth['match_id'] = df_truth[truth_tag_col].astype(str).str.extract(r'(\d+)').astype(float)

    # Drop any rows where an ID couldn't be extracted
    df_fits = df_fits.dropna(subset=['match_id'])
    df_truth = df_truth.dropna(subset=['match_id'])

    # Merge on our new clean numeric ID
    df_merged = pd.merge(df_fits, df_truth, on='match_id')
        
    if df_merged.empty:
        print("\nError: Merged dataset is still empty! The extracted numbers don't match.")
        print(f"Extracted Fit IDs: {df_fits['match_id'].tolist()[:5]}")
        print(f"Extracted Truth IDs: {df_truth['match_id'].tolist()[:5]}")
        return

    # Calculate Residuals (Reconstructed - True)
    # Modulo operation handles wrap-around cases (e.g., 359 deg true vs 1 deg reco = +2 deg residual)
    diff = df_merged[fit_col] - df_merged[true_col]
    df_merged['Residual (deg)'] = (diff + 180) % 360 - 180 

    print(f"\nSuccessfully merged {len(df_merged)} data points. Generating plots...")

    # --- Plot 1: Residuals vs True Angle ---
    plt.figure(figsize=(10, 6))
    plt.errorbar(df_merged[true_col], df_merged['Residual (deg)'], 
                 yerr=df_merged[err_col], fmt='o', color='black', 
                 ecolor='gray', capsize=3, markersize=6, label='Data Points')
    
    plt.axhline(0, color='red', linestyle='--', label='Ideal (Zero Residual)')
    
    #plt.title(r'\textbf{NuLat Unblinding: Residuals vs True Angle}')
    plt.xlabel(r'True Azimuthal Angle ($^\circ$)')
    plt.ylabel(r'Residual ($^\circ$) [Reconstructed - True]')
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    
    scatter_path = os.path.join(output_dir, "unblinding_scatter_residuals.pdf")
    plt.savefig(scatter_path)
    plt.close()

    # --- Plot 2: Histogram of Residuals ---
    plt.figure(figsize=(8, 6))
    
    mean_res = df_merged['Residual (deg)'].mean()
    std_res = df_merged['Residual (deg)'].std()
    
    plt.hist(df_merged['Residual (deg)'], bins=15, 
             color='steelblue', edgecolor='black', alpha=0.7)
    
    plt.axvline(mean_res, color='red', linestyle='dashed', linewidth=2, 
                label=rf'Mean Offset = ${mean_res:.2f}^\circ$')
    
    stats_text = rf"$\mu = {mean_res:.2f}^\circ$" + "\n" + rf"$\sigma = {std_res:.2f}^\circ$"
    plt.gca().text(0.95, 0.95, stats_text, transform=plt.gca().transAxes,
                   fontsize=14, verticalalignment='top', horizontalalignment='right',
                   bbox=dict(boxstyle='round', facecolor='white', alpha=0.8))

    #plt.title(r'\textbf{NuLat Unblinding: Residual Distribution}')
    plt.xlabel(r'Reconstruction Residual ($^\circ$)')
    plt.ylabel(r'Counts')
    plt.legend(loc='upper left')
    plt.grid(True, axis='y', alpha=0.3)
    plt.tight_layout()
    
    hist_path = os.path.join(output_dir, "unblinding_hist_residuals.pdf")
    plt.savefig(hist_path)
    plt.close()

    print(f"\nUnblinding Complete!")
    print(f"Mean Residual: {mean_res:.3f} degrees")
    print(f"Std Deviation: {std_res:.3f} degrees")
    print(f"Plots saved to {output_dir}/")

if __name__ == "__main__":
    # --- USER CONFIGURATION ---
    # Using the exact paths from your console output
    FITS_FILE = "/home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/output/analysis/blind_analysis_fits.csv" 
    TRUTH_FILE = "/home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/macros/blind/secret_truth_vault.csv"
    
    # You might want the plots to go into your analysis folder
    OUTPUT_DIR = "/home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/output/analysis/blind_study"
    
    run_unblinding(FITS_FILE, TRUTH_FILE, OUTPUT_DIR)
