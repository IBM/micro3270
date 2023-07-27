# Building
Building this project uses `podman`, which can be installed using [Podman Desktop](https://podman-desktop.io/).

To build locally using `podman`:
```bash
podman build . -t ibm/micro3270
```

## Using build script
Use the `build-oci.sh` script for quickly rebuilding multi-architecture images and creating the manifest.

Additional `podman machine` configurations may be necessary to enable multi-architecture builds.

```bash
podman machine ssh
sudo rpm-ostree install qemu-user-static
systemctl reboot
```

```bash
./scripts/build-oci.sh
```

### Building c3270 from source
This image pulls the latest stable tag, currently `4.2ga10`, from the official `x3270` [GitHub Repository](https://github.com/pmattes/x3270).

Latest stable versions can be seen on the `x3270` wiki [Downloads page](https://x3270.miraheze.org/wiki/Downloads).