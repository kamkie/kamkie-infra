# minishift
https://github.com/minishift/minishift

Minishift is a tool that helps you run OpenShift locally by running a single-node OpenShift cluster inside a VM. You can try out OpenShift or develop with it, day-to-day, on your local host.

Minishift uses libmachine for provisioning VMs, and OpenShift Origin for running the cluster. The code base is forked from the Minikube project.

## Requirements
* openshift CLI (oc)
* macOS
  *  xhyve (default) or VirtualBox
* Linux
  * VirtualBox or KVM (default)
* Windows
  * VirtualBox or Hyper-V (default)
  * To use Minishift with Hyper-V ensure that, after you install Hyper-V, you also add a Virtual Switch using the Hyper-V Manager and set the environment variable `HYPERV_VIRTUAL_SWITCH` to this virtual switch. For specific configuration steps see the [Setting Up the Driver Plug-in](https://docs.openshift.org/latest/minishift/getting-started/setting-up-driver-plugin.html) section.
  * On the Windows operating system, due to issue #236, you need to execute the Minishift binary from your local C:\ drive. You cannot run Minishift from a network drive.
  * Minishift will use any SSH binary found on the PATH in preference to internal SSH code. Ensure that any SSH binary in the system PATH does not generate warning messages as this will cause installation problems such as issue #1923.
  * user needs to be in Hyper-V Administrators grup or you need to run commands as administrator
* VT-x/AMD-v virtualization must be enabled in BIOS
* Internet connection on first run

## Installation
### manual
* download `oc` from [github relases](https://github.com/openshift/origin/releases) and put on PATH
* download `minihift` from [github relases](https://github.com/minishift/minishift/releases) and put on PATH

### Chocolatey (recomended)
* `choco install openshift-cli`
* `choco install minishift`

### Homebrew
* `brew install openshift-cli`
* `brew cask install minishift`

### scripts from this repo
using git bash
```bash
cd minishift
./install-windows.sh
```

## Setup
using git bash
```bash
./minishift-start-windows-hyperv.sh
```

## Usage
[more details](https://docs.openshift.org/latest/minishift/using/index.html)
* deploy simple app from cli
```bash
oc new-app https://github.com/openshift/nodejs-ex -l name=myapp
oc expose svc/nodejs-ex
minishift openshift service nodejs-ex --in-browser
```
* `minishift console` will open openshift web console in default browser 
you can use `developer` as a username with any password and `admin` with any password as administrator (similar to system:admin from terminal)
* choose `Pipeline Build Example` from catalog and create new deployment
* use `eval $(minishift docker-env)` to point docker to your minishift docker daemon. This will allow to build images directly on minishift instance. Also then you can stop docker for windows to free up some memory 

## spring boot
[deploy spring boot](spring-boot.md)
