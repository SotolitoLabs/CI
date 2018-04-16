# Setup Jenkins Server


The following instructions detail the procedure to install the Jenkins server for containers testing using a KVM virtual machine with Fedora ARM.

If you're installing a CI server directly on an ARM board, just skip the KVM related instructions.


### Install host requisites

```
sudo dnf install  @virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo dnf install -y libguestfs-tools
sudo dnf install qemu-system-arm
```

### Get Fedora ARM image

```
wget https://download.fedoraproject.org/pub/fedora/linux/releases/27/Server/armhfp/images/Fedora-Server-armhfp-27-1.6-sda.raw.xz
```


### Extract the image

```
unxz Fedora-Server-armhfp-27-1.6-sda.raw.xz
```

### Extract the kernel and initramfs for use with booting

```
virt-builder --get-kernel Fedora-Server-armhfp-27-1.6-sda.raw
```

### Move the files to the default libvirt image location

```
sudo mv Fedora-Server-armhfp-27-1.6-sda.raw vmlinuz-4.13.9-300.fc27.armv7hl initramfs-4.13.9-300.fc27.armv7hl.img /var/lib/libvirt/images/
```


### Create the virtual machine

```
sudo virt-install \
    --name Fedora-Server-armhfp-27 --ram 4096 --arch armv7l --import --os-variant fedora22 \
    --disk /var/lib/libvirt/images/Fedora-Server-armhfp-27-1.6-sda.raw \
    --boot kernel=/var/lib/libvirt/images/vmlinuz-4.13.9-300.fc27.armv7hl,initrd=/var/lib/libvirt/images/initramfs-4.13.9-300.fc27.armv7hl.img,kernel_args="console=ttyAMA0 rw root=LABEL=_/ rootwait"
```


### VM Operations

Domain creation completed.
You can restart your domain by running:
  virsh --connect qemu:///system start Fedora-Server-armhfp-27


Alternatively, you can first check which machines are available in your domain

```
sudo virsh list --all
```
Then start it manually
 
```
sudo virsh start Fedora-Server-armhfp-27
```

To connect to the VM's console :

```
sudo virsh console Fedora-Server-armhfp-27
```
To exit the console use Shift+Ctrl+]


or via SSH, you need to determine which machine number your VM is within the domain

```
$ sudo virsh list
 Id    Name                           State
----------------------------------------------------
 1     Fedora-Server-armhfp-27        running

 $ sudo virsh domifaddr 1
 Name       MAC address          Protocol     Address
-------------------------------------------------------------------------------
 vnet0      52:54:00:79:30:57    ipv4         192.168.122.170/24
```


 Then just ssh using the host's ip returned address 




Finally, to shut it down

```
sudo virsh shutdown Fedora-Server-armhfp-27
```




### Install Jenkins pre-requisites

TBD

