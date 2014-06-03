# README #


### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact


-------------------------------------------------------------------------
# vagrant-webdev

## What is vagrant-webdev ?

vagrant-webdev is a [Vagrant](http://www.vagrantup.com) based development box that can be used to quickly setup a web development box.

## What constitutes the development stack ?

In the first release the following tools are present

1. Ubuntu 12.04 (Precise Pangolin) 32 bit base box.  (Referred to as `GUEST` throughout the document)
2. Oracle JDK 7
3. Apache Maven
4. Nodejs and NPM
5. yeoman stack
6. mongodb

## How do I start using vagrant-webdev?

The best part here is that you can use vagrant-webdev on Windows, Mac or any Linux environment, and the steps to do so are exactly the same.

### Step 1. System Setup

Go ahead and get the following tools installed on your system (Referred to as `HOST` throughout the document) 

1. Git
2. [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
3. [Vagrant](https://www.vagrantup.com/downloads.html)

_I would recommend using the latest stable versions of these tools_

I also assume a directory structure as follows. So go ahead and create one as mentioned below

	| Your home directory
	|--- projects
	|------ vagrant-webdev-workspace


### Step 2. Clone the bitbucket repository

Follow these commands to clone the vagrant-webdev repository

	cd ~
	cd projects
	git clone https://hemenkapadia@bitbucket.org/hemenkapadiapublic/vagrant-webdev.git

This will checkout the vagrant-webdev code from git on your machine and your directory structure would look like 

	| Your home directory
	|--- projects
	|------ vagrant-webdev-workspace
	|------ vagrant-webdev

### Step 3. Start the `HOST` machine

Follow these commands to start the `HOST` machine 

	cd ~
	cd projects
	cd vagrant-webdev
	vagrant up
	
This step will take a long time to complete for the first time, so have some patience. 

_Only for the first time, vagrant will download the Ubuntu base box (approx 300 MB) and provision it. during provisioning step it downloads the Oracle JDK 7 installer (approx 150 MB) and that too takes sometime depending on your internet connection. Be patient, as long as you do not see any error you should be good._

If the above step completed successfuly you have a fully operational web development system ready at your disposal, with all the tools mentioned above pre-installed for you.

### Step 4. Connect to the `HOST` and verify

To connect to your vagrant-webdev environment issue the command

	vagrant ssh
	
This will open up a SSH session with the `HOST` and issue you a prompt.

The below commands are executed on the `HOST` and not the `GUEST`. Note the output for the same.

