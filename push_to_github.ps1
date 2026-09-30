param([switch]$Check)

$ErrorActionPreference = 'Stop'
$repoPath = (Resolve-Path -LiteralPath $PSScriptRoot).Path
$expectedRemote = 'https://github.com/santrimanofficial26-oss/pgrimatraman.git'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git belum tersedia di PATH.'
}

$actualRemote = & git -C $repoPath remote get-url origin
if ($LASTEXITCODE -ne 0 -or $actualRemote.TrimEnd('/') -ne $expectedRemote) {
    throw "Remote origin harus $expectedRemote (sekarang: $actualRemote)."
}

$branch = & git -C $repoPath branch --show-current
if ($LASTEXITCODE -ne 0 -or $branch -ne 'main') {
    throw "Pindah ke branch main sebelum push (sekarang: $branch)."
}

Write-Host "Folder client: $repoPath"
Write-Host "Remote: $actualRemote"
Write-Host "Branch: $branch"
& git -C $repoPath status --short
if ($LASTEXITCODE -ne 0) { throw 'Gagal membaca status Git.' }
if ($Check) { return }

& git -C $repoPath add -A
if ($LASTEXITCODE -ne 0) { throw 'Gagal menyiapkan perubahan untuk commit.' }

& git -C $repoPath diff --cached --quiet
if ($LASTEXITCODE -eq 1) {
    & git -C $repoPath commit -m 'Update PGRI Matraman client iframe'
    if ($LASTEXITCODE -ne 0) { throw 'Commit gagal.' }
} elseif ($LASTEXITCODE -ne 0) {
    throw 'Gagal memeriksa perubahan Git.'
}

& git -C $repoPath push -u origin main
if ($LASTEXITCODE -ne 0) {
    throw 'Push gagal. Periksa autentikasi GitHub atau riwayat branch remote.'
}

Write-Host 'Selesai: perubahan folder client terkirim ke GitHub.'
