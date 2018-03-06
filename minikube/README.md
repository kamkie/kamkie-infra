# minikube 
https://github.com/kubernetes/minikube

## Requirements
* kubectl
* macOS
  * Hyperkit driver, xhyve driver, VirtualBox, or VMware Fusion
* Linux
  * VirtualBox or KVM
  * NOTE: Minikube also supports a --vm-driver=none option that runs the Kubernetes components on the host and not in a VM. Docker is required to use this driver but no hypervisor. If you use --vm-driver=none, be sure to specify a bridge network for docker. Otherwise it might change between network restarts, causing loss of connectivity to your cluster.
* Windows
  * VirtualBox or Hyper-V
* VT-x/AMD-v virtualization must be enabled in BIOS
* Internet connection on first run
