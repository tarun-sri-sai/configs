$env:LANG = 'en_US.UTF-8'

function restic {
  & restic.exe --password-command 'bw get password "restic / tarun / my-files"' @args
}

$env:EDITOR = 'nvim'
