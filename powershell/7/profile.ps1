# starship config
Invoke-Expression (&starship init powershell)

# zoxide config (always initialize zoxide at the end of the file)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
