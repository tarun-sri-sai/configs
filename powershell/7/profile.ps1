# starship config
Invoke-Expression (&starship init powershell)

# tmux alias
function txss {
    & tmux -u new-session -As default
}

# zoxide config (always initialize zoxide at the end of the file)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
