## Overview
 A container image is a standardized package that includes all of the files, binaries, libraries, and configurations to run a container. It's an inmutable file where from we will build our [[Docker Container]]
 
There are two important principles of images:

- Images are immutable. Once an image is created, it can't be modified. You can only make a new image or add changes on top of it.

- Container images are composed of layers. Each layer represents a set of file system changes that add, remove, or modify files.

These two principles let you to extend or add to existing images. For example, if you are building a Python app, you can start from the Python image and add additional layers to install your app's dependencies and add your code. This lets you focus on your app, rather than Python itself.

A Docker image is a folder; it must contain your [[Dockerfile]] at the root of the folder but can also contain a bunch of other files so that you can then copy them directly into your VM.
## Image layers

Each layer in an image contains a set of filesystem changes - additions, deletions, or modifications. Let's look at a theoretical image:

1. The first layer adds basic commands and a package manager, such as apt.
2. The second layer installs a Python runtime and pip for dependency management.
3. The third layer copies in an applications specific requirements.txt file.
4. The fourth layer installs that applications specific dependencies.
5. The fifth layer copies in the actual source code of the application.

This example might look like:

![screenshot of the flowchart showing the concept of the image layers](https://docs.docker.com/get-started/docker-concepts/building-images/images/container_image_layers.webp)

This is beneficial because it allows layers to be reused between images. For example, imagine you wanted to create another Python application. Due to layering, you can leverage the same Python base. This will make builds faster and reduce the amount of storage and bandwidth required to distribute the images. The image layering might look similar to the following:

![screenshot of the flowchart showing the benefits of the image layering](https://docs.docker.com/get-started/docker-concepts/building-images/images/container_image_layer_reuse.webp)

Layers let you extend images of others by reusing their base layers, allowing you to add only the data that your application needs.
## Documentation
- [What is an image?](https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-an-image/)
- [Understanding the image layers](https://docs.docker.com/get-started/docker-concepts/building-images/understanding-image-layers/)