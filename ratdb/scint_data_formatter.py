import numpy as np

def format_ratdb_arrays(wavelengths, intensities):
    """
    Takes lists of wavelengths and intensities and prints them
    in RATPAC ratdb format.
    """
    # Ensure data is sorted by wavelength
    sorted_indices = np.argsort(wavelengths)
    w_sorted = np.array(wavelengths)[sorted_indices]
    i_sorted = np.array(intensities)[sorted_indices]

    # Normalize intensities so the peak is 1.0 (optional but good practice)
    if len(i_sorted) > 0:
        i_sorted = i_sorted / np.max(i_sorted)

    print("\nCopy and paste these lines into your OPTICS table in the .ratdb file:\n")
    
    # 1. The Value1 array (Wavelengths)
    w_str = "SCINTILLATIONWAVEFORM_value1: ["
    for w in w_sorted:
        w_str += f"{w:.1f}, "
    w_str += "],"
    print(w_str)
    print("")

    # 2. The Value2 array (Intensities/Probabilities)
    i_str = "SCINTILLATIONWAVEFORM_value2: ["
    for i in i_sorted:
        i_str += f"{i:.3f}, "
    i_str += "],"
    print(i_str)
    print("")

if __name__ == "__main__":
    # --- EXAMPLE USAGE ---
    # CSV data you get from WebPlotDigitizer extraction of Eljen EJ-200 spectrum
    raw_data = """
    396.0004365858982, 0
    400.0017463435931, 0.005893909626718985
    402.00349268718617, 0.013752455795677854
    404.0104780615586, 0.04518664047151266
    405.0179000218293, 0.07858546168958735
    406.0248853962017, 0.11001964636542239
    408.03929273084475, 0.1748526522593321
    409.94564505566467, 0.25343811394891946
    412.07771228989304, 0.34774066797642444
    413.9932329185767, 0.46758349705304514
    415.0093865968129, 0.5402750491159136
    416.02204758786286, 0.5972495088408644
    418.0534817725387, 0.7387033398821218
    419.9720585025103, 0.8722986247544204
    420.9834097358655, 0.9233791748526523
    421.9925780397293, 0.9646365422396856
    422.99694389871206, 0.9842829076620825
    424, 0.9980353634577603
    425.0004365858982, 1
    426, 0.9980353634577603
    426.99781707050863, 0.9882121807465618
    427.9956341410172, 0.9783889980353635
    429.99126828203447, 0.9587426326129667
    431.9834097358655, 0.9233791748526523
    433.865313250382, 0.8919449901768173
    434.97249508840866, 0.8742632612966601
    435.9672560576293, 0.8506876227897839
    437.95590482427417, 0.7996070726915521
    439.7236411263916, 0.7544204322200393
    442.04562322636974, 0.7033398821218075
    444.0360183366077, 0.6601178781925344
    445.02946954813353, 0.630648330058939
    446.02466710325257, 0.6090373280943026
    448.01680855708355, 0.5736738703339882
    450.01069635450773, 0.5461689587426326
    454.9954158480681, 0.47740667976424356
    459.6511678672779, 0.42829076620825146
    464.9735865531543, 0.37917485265225925
    469.9552499454267, 0.2966601178781926
    474.9386596812923, 0.22200392927308443
    479.4824274175944, 0.1689587426326129
    485.02750491159134, 0.12180746561886058
    490.02139270901546, 0.09430255402750487
    495.0152805064396, 0.06679764243614938
    499.45623226369787, 0.05108055009823187
    """
    
    # Simple parsing logic
    wavelengths = []
    intensities = []
    
    lines = raw_data.strip().split('\n')
    for line in lines:
        parts = line.split(',')
        if len(parts) == 2:
            try:
                w = float(parts[0].strip())
                i = float(parts[1].strip())
                wavelengths.append(w)
                intensities.append(i)
            except ValueError:
                continue

    if wavelengths:
        format_ratdb_arrays(wavelengths, intensities)
    else:
        print("No valid data found. Please paste your CSV data into the 'raw_data' string.")
