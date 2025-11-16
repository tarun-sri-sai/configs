function restic () {
    & restic.exe --insecure-no-password @args
}

$OutputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
