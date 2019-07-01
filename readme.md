# SelfieCert

Generates a root CA key and cert, along with a website key and cert, and adds the root CA certificate to the local Windows trust store.

SelfieCert is a simple wrapper for OpenSSL with defaults for local website development.

## Installation

### For use with bash on Linux, Mac OSX, or Windows (via [WSL](https://docs.microsoft.com/en-us/windows/wsl/about) or [Git BASH](https://gitforwindows.org/))

Open a bash prompt and run:

```
curl -s https://raw.githubusercontent.com/labaneilers/selfiecert/master/install.sh | bash
```

### Windows PowerShell

On Windows, even if you use PowerShell as your terminal, you need a bash shell to run your command scripts. The most commonly available one is [Git BASH](https://gitforwindows.org/) (comes with Git for Windows).

Open PowerShell as administrator, and run:

```
. { iwr -useb https://raw.githubusercontent.com/labaneilers/selfiecert/master/install.ps1 } | iex
```


## Usage

```
selfiecert [-c|--config=<config file path>] [-o|--outdir=<certs output dir>] [--help]
```

* **-c|--config**: Specify a config file to use instead of the default. An example is [here](./selfiecert-config.cnf).
* **-o|--output**: The directory to output the certificate and key files. The default is ```~/.selfiecert```
* **--help**: Print help

# Contributing

Some useful features I'd love to add:

* Before each stage of generating certs/keys, check that any existing files match the files from the previous stage.
* Mac OSX support: Right now, adding the root CA to the trust store only works on Windows. 
* Have a more intelligent way to handle an existing SelfieCertCA already existing in the trust store that doesn't match the files in ~/.selfiecert