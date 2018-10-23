# Packer Example

This example repository demonstrates the simple usage of Packer.

Examples in this repo:

1. Basic AMI image
2. Image with Redis pre-installed
3. Parallel Builds on AWS and DigitalOcean
4. Turning machine image into a Vagrant Box

Packer template files are written in json format.

### Packer template file validation

This is to ensure the template file is correct such that it has the correct Packer syntax.

e.g.
```bash
packer validate basic-image.json
```

### Build machine image

Once validated, we can build the machine image using the validated template file.

e.g.
```bash
packer build basic-image.json
```

### Basic AMI image

See `basic-image.json`

### Image with Redis pre-installed

Using Packer provisioners to run predefined scripts to install certain software onto the machine images.

e.g.

```json
"provisioners" : [
        {
            "type" : "shell",
            "inline" : [
                "sleep 30",
                "sudo apt-get update",
                "sudo apt-get install -y redis-server"
            ]
        }
    ]
```

### Parallel Builds on AWS and DigitalOcean

Packer allows the generation of multiple machine images for different cloud providers and even multiple machine images for the same cloud providers/platforms at once.

To achieve this Packer syntax contains a "builders" section of the template which is used to define the list of 'builders' to build the machine image(s) for the different and/or same cloud provider/platform.

e.g.

```json
"builders" : [
        {
            // ... AWS
        },
        {
           // ... DigitalOcean
        }
    ],
```

See the `image-with-redis-parallel-builds.json` for detailed code block.

### Turning machine image into Vagrant Box

Makes use of "post processors".

e.g.

```json
"post-processors" : ["vagrant"] 
```
