#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
expected_remote='https://github.com/santrimanofficial26-oss/pgrimatraman.git'

if ! command -v git >/dev/null 2>&1; then
    printf 'Git belum tersedia di PATH.\n' >&2
    exit 1
fi

actual_remote="$(git -C "$repo_dir" remote get-url origin 2>/dev/null || true)"
if [[ "${actual_remote%/}" != "$expected_remote" ]]; then
    printf 'Remote origin harus %s (sekarang: %s).\n' "$expected_remote" "${actual_remote:-tidak ada}" >&2
    exit 1
fi

branch="$(git -C "$repo_dir" branch --show-current)"
if [[ "$branch" != 'main' ]]; then
    printf 'Pindah ke branch main sebelum push (sekarang: %s).\n' "${branch:-tidak ada}" >&2
    exit 1
fi

if [[ "${1:-}" == '--check' ]]; then
    printf 'Folder client: %s\nRemote: %s\nBranch: %s\n' "$repo_dir" "$actual_remote" "$branch"
    git -C "$repo_dir" status --short
    exit 0
fi

git -C "$repo_dir" add -A
if ! git -C "$repo_dir" diff --cached --quiet; then
    git -C "$repo_dir" commit -m "${1:-Update PGRI Matraman client iframe}"
fi

git -C "$repo_dir" push -u origin main
printf 'Selesai: perubahan folder client terkirim ke %s\n' "$expected_remote"
