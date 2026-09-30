# PGRI Cabang Matraman — wrapper Vercel client

Folder ini adalah proyek Vercel terpisah untuk portal client. `index.html` menampilkan deployment Google Apps Script client di dalam iframe layar penuh.

**Apps Script client:** `https://script.google.com/macros/s/AKfycbx0KfH9ETgdSKzjv2mhl6tKMTnutJO0amZyi-cLi-Q6IOF3E1CGfbgRnB2x0zjrTgV6/exec`

**Repo pemeliharaan:** `https://github.com/santrimanofficial26-oss/pgrimatraman.git`

**Folder testing lama:** `../vercel-iframe/` (tetap terpisah dan tidak diubah).

## Alur pemeliharaan

1. Publikasikan perubahan `index.html` dan `kode.gs` ke **deployment Apps Script client**. Wrapper ini tidak memuat kode portal lokal dan tidak dapat memperbarui versi Apps Script dengan sendirinya.
2. Pastikan deployment Apps Script client dapat dibuka oleh pengunjung dan mengizinkan tampilan di dalam iframe. Spreadsheet, Drive, akun, dan izin Apps Script tetap dikelola oleh client.
3. Hubungkan repo `pgrimatraman` ke Vercel dengan **Root Directory** `./` (jika repo berisi isi folder ini saja), **Framework Preset** `Other`, serta tanpa Build Command.
4. Hubungkan domain yang dikelola pemelihara ke proyek Vercel tersebut. Perubahan domain atau wrapper dikelola di Vercel/repo pemelihara; data portal tetap di akun client.

Untuk mengirim folder ini ke GitHub setelah autentikasi Git tersedia:

- Windows: klik dua kali `push_to_github.bat`. Jendela akan tetap terbuka agar hasilnya bisa dibaca.
- Git Bash/Linux/macOS: `bash ./push_to_github.sh` (cek konfigurasi saja: `bash ./push_to_github.sh --check`)
- PowerShell: `./push_to_github.ps1` (cek konfigurasi saja: `./push_to_github.ps1 -Check`)

Semua skrip membuat commit jika ada perubahan, lalu melakukan push biasa tanpa force. Jika branch remote punya riwayat berbeda, push akan berhenti agar isi repo tidak tertimpa.
