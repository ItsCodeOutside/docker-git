# docker-git
A small attempt a git docker image based on Alpine Linux and jkarlosb's existing project on [GitHub](https://github.com/jkarlosb/git-server-docker). This is a new repo instead of a fork because it is very different to the original.

### Quick Setup

1. Pull this repo and save it to a location, we'll use */home/user/docker-git* for this example 

2. After pulling this repository just run:

	`$ docker build -t docker-git .`


3. To execute a container from the image run:

	`$ docker run -d -p 2222:22 -v /home/user/docker-git/git-server/keys/:/git-server/keys -v /home/user/docker-git/repos/:/git-server/repos docker-git`

### Allowing A User to Connect

Copy the user's public SSH key to */home/user/docker-git/git-server/keys/* (or the location you used for your run command). This example assumes you have a public key for your user:

	`$ cp ~/.ssh/id_rsa.pub /home/user/docker-git/git-server/keys/mykey.pub`

### Disallowing a User

Simply remove their key from the keys directory, for example:

	`$ rm /home/user/docker-git/git-server/keys/mykey.pub`

### Warnings

This actually runs with only one user called git and when you add more keys you're just letting more people run as this default user. There's no way to hide repositories from other users.


