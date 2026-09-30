$ErrorActionPreference = 'Stop'
$repoPath = (Resolve-Path -LiteralPath $PSScriptRoot).Path
$expectedRemote = 'https://github.com/santrimanofficial26-oss/pgrimatraman.git'

$actualRemote = (& git -C $repoPath remote get-url origin 2>$null)
if ($LASTEXITCODE -ne 0 -or $actualRemote.TrimEnd('/') -ne $expectedRemote.TrimEnd('/')) {
    throw "Remote origin harus $expectedRemote"
}

& git -C $repoPath status --short
& git -C $repoPath push -u origin main
if ($LASTEXITCODE -ne 0) {
    throw 'Push gagal. Periksa autentikasi GitHub atau sinkronkan riwayat branch remote terlebih dahulu.'
}
