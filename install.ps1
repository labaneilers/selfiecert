$target_dir = $env:INSTALL_DIR
if (! $env:INSTALL_DIR) {
    $target_dir = "C:\Program Files\Git\cmd"
}
$source = "https://raw.githubusercontent.com/labaneilers/selfiecert/master"

if (!( test-path $target_dir)) {
    "ERROR: Couldn't find default install dir: $target_dir"
    "You can set the target install dir by setting an environment variable: `$env:INSTALL_DIR"
    exit 1
}

iwr -uri "$source/selfiecert.cmd" -outfile "$target_dir\selfiecert.cmd"
iwr -uri "$source/selfiecert" -outfile "$target_dir\selfiecert.sh"
iwr -uri "$source/selfiecert-trust-ca.ps1" -outfile "$target_dir\selfiecert-trust-ca.ps1"
iwr -uri "$source/selfiecert-config.cnf" -outfile "$target_dir\selfiecert-config.cnf"

"Installed selfiecert at $target_dir\selfiecert.cmd"