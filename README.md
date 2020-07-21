Adobe Digital Editions Dockerized
=================================

Runs Adobe Digital Editions 2.0.1 in a Docker container using Wine and automates
the downloading of e-books from ACSM files.

Authorizing Adobe IDs
---------------------

One or more Adobe IDs may be authorized. There will be a Docker image for each
Adobe ID holding the authorized installation of Adobe Digital Editions. When
authorizing a new Adobe ID a unique tag for the Docker image must be provided.
One might for example use the name of the person the Adobe ID belongs to.

    ./newid alice

This will run a Docker container and install a fresh instance of Adobe Digital
Editions inside. Open a VNC client of your choice
([TigerVNC](https://tigervnc.org/) works) and connect to `localhost:5900`.
When the script runs for the first time the Dockerfile is built before the VNC
server starts. Be patient and retry connecting. Once you're connected you will
likely be seeing a blackscreen. Wait for the Adobe Digital Editions installer to
pop up and advance the installation. This should open up the application.
Authorize your Adobe ID under *Help -> Authorize Computer* then exit via
*File -> Exit* which will stop the container. This creates the Docker image
`adobe_diged_docker:alice` holding the authorized instance of Adobe Digital
Editions. The script must be started from the git repository in order to locate
the Dockerfile and cannot be running in parallel due to the open port.

Downloading Books
-----------------

This process of downloading e-books is fully automated and can easily be
integrated into an existing script.

    ./bookdl alice,bob mybook.acsm

This will start the Docker containers `adobe_diged_docker:alice` and
`adobe_diged_docker:bob` and pass the ACSM file to both instances of Adobe
Digital Editions. Since there is no good way to detect failure we just wait for
any instance to download the book to disk. The optional third argument specifies
the directory to put the downloaded book and defaults to the current directory.
If no instance started the download after 20 seconds the script timeouts with a
non-zero exit status. The script can be executed from any directory and multiple
invocations can run in parallel.

DeDRM Key Retrieval
-------------------

Keys for [DeDRM](https://github.com/apprenticeharper/DeDRM_tools) can be
generated from an authorized Adobe Digital Editions installation.

    ./getkey alice

An optional second argument specifies the directory to put the generated key
file and defaults to the current directory.

Known Issues
------------

This was developed on Arch Linux and it turned out later it doesn't run on
Debian 10. It will however work on Debian 11. My best guess is that it
doesn't work with older kernels.
