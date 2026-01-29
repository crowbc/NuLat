void readValidation(const char* filename) {
  
  TFile *_file0 = TFile::Open(filename);
  
  if (!_file0 || _file0->IsZombie()) {
    printf("Error: Cannot open file %s\n", filename);
    return;
  }

  auto T = (TTree*)_file0->Get("output");
  T->SetScanField(-1);

  // Columns:
  // Row (Implicit) : Instance (Implicit) : [Requested Columns]
  // Removed 'evid' as it is broken (-1).
  const char* columns = "trackPDG : trackProcess : "
                        "mcx : mcy : mcz : "
                        "trackPosX : trackPosY : trackPosZ : "
                        "trackTime : trackKE";

  // Filter:
  // 1. Neutrons (2112)
  // 2. Positrons (-11)
  // 3. Gammas (22) - NEW
  const char* cuts = "trackPDG == 2112 || trackPDG == -11 || trackPDG == 22";

  // Formatting
  const char* format = "colsize=25 precision=9 col=::20.10";

  T->Scan(columns, cuts, format);
}
