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


### Reconnect to VM

Domain creation completed.
You can restart your domain by running:
  virsh --connect qemu:///system start Fedora-Server-armhfp-27


### Install Jenkins pre-requisites

TBD

