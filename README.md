## What is vagrant-webdev ?

vagrant-webdev is a [Vagrant](http://www.vagrantup.com) based development box that can be used to quickly set-up a web development box.

## What constitutes the development stack ?

The following forms the development stack

1. Ubuntu 12.04 (Precise Pangolin) 32 bit base box.  (Referred to as `GUEST` throughout the document)
2. Oracle JDK 7
3. Apache Maven
4. Nodejs and NPM
5. yeoman stack
6. mongodb

## How do I start using vagrant-webdev?

The best part here is that you can use vagrant-webdev on Windows, Mac or any Linux environment, and the steps to do so are exactly the same.

### Step 1. System Set-up

Go ahead and get the following tools installed on your system (Referred to as `HOST` throughout the document) 

1. [Git](http://git-scm.com/downloads)
2. [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
3. [Vagrant](https://www.vagrantup.com/downloads.html)

> Note - If your `HOST` system is Linux or Mac OSX, I strongly recommend you to use [vagrant-webdev-nfs](https://bitbucket.org/hemenkapadiapublic/vagrant-webdev-nfs) repository. It uses nfs to overcome performance issues with virtualbox shared folders, used by vagrant-webdev. This issues supposedly does not happen when the `HOST` is Windows.

To know more about NFS performance read:
1. [Use NFS to speed up your Vagrant ](https://coderwall.com/p/uaohzg)
2.  [NFS shared folders](http://friendsofvagrant.github.io/v1/docs/nfs.html)

I also assume a directory structure as follows. So go ahead and create one as mentioned below

	| Your home directory
	|--- projects
	|------ vagrant-webdev-workspace

> vagrant-webdev-workspace is an important shared folder between your `GUEST` and `HOST`. This folder will contain our development code, such that you can use tools that you are comfortable with (IDE, Browser etc.) that are already installed on your `HOST` for development and testing, but use the `GUEST` for build and deployment. 

### Step 2. Clone the BitBucket repository

Follow these commands to clone the vagrant-webdev repository on the `HOST`

	cd ~
	cd projects
	git clone https://hemenkapadia@bitbucket.org/hemenkapadiapublic/vagrant-webdev.git

This will clone the vagrant-webdev code from git on your machine and your directory structure would look like 

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

> For the first time, vagrant will download the Ubuntu base box (approx 300 MB) and provision it. During provisioning, it also downloads the Oracle JDK 7 installer (approx 150 MB) which also takes time depending on your internet connection. Be patient, as long as you do not see any error you should be good.

If the above step completed successfully you have a fully operational web development system ready at your disposal, with all the tools mentioned in the development stack above pre-installed for you.

### Step 4. Connect to the `HOST` and verify

To connect to your vagrant-webdev environment issue the command in the vagrant-webdev directory

	vagrant ssh
	
This will open up a SSH session with the `HOST` and issue you a prompt as shown below

	hemen@hemen-MXC061:~/projects/vagrant-webdev$ vagrant ssh
	Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)

	 * Documentation:  https://help.ubuntu.com/
	Welcome to your Vagrant-built virtual machine.
	Last login: Mon Jun  2 21:36:13 2014 from 10.0.2.2
	vagrant@precise32:~$ 

Notice the change in the prompt. It indicates that you are now on the `HOST` box.

I use the following commands to ensure vagrant-webdev has been provisioned correctly. Verify once your machine is up too.

	hemen@hemen-MXC061:~/data/projects/vagrant-webdev$ vagrant ssh
	Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)

	 * Documentation:  https://help.ubuntu.com/
	Welcome to your Vagrant-built virtual machine.
	Last login: Fri Sep 14 06:22:31 2012 from 10.0.2.2
	vagrant@precise32:~$ env | grep java
	DERBY_HOME=/usr/lib/jvm/java-7-oracle/db
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin:/usr/share/maven3/bin:/opt/vagrant_ruby/bin
	JAVA_HOME=/usr/lib/jvm/java-7-oracle
	NODE_PATH=/usr/lib/nodejs:/usr/lib/node_modules:/usr/share/javascript
	J2SDKDIR=/usr/lib/jvm/java-7-oracle
	J2REDIR=/usr/lib/jvm/java-7-oracle/jre
	vagrant@precise32:~$ env | grep M2
	M2=/usr/share/maven3/bin
	M2_HOME=/usr/share/maven3
	vagrant@precise32:~$ mvn -version
	Apache Maven 3.2.1 (ea8b2b07643dbb1b84b6d16e1f08391b666bc1e9; 2014-02-14T17:37:52+00:00)
	Maven home: /usr/share/maven3
	Java version: 1.7.0_60, vendor: Oracle Corporation
	Java home: /usr/lib/jvm/java-7-oracle/jre
	Default locale: en_US, platform encoding: ISO-8859-1
	OS name: "linux", version: "3.2.0-23-generic-pae", arch: "i386", family: "unix"
	vagrant@precise32:~$ java -version
	java version "1.7.0_60"
	Java(TM) SE Runtime Environment (build 1.7.0_60-b19)
	Java HotSpot(TM) Client VM (build 24.60-b09, mixed mode)
	vagrant@precise32:~$ node -v
	v0.10.28
	vagrant@precise32:~$ npm -v 
	1.4.9
	vagrant@precise32:~$ mongo --version
	MongoDB shell version: 2.4.10
	vagrant@precise32:~$ mongod --version
	db version v2.4.10
	Tue Jun  3 21:45:37.791 git version: e3d78955d181e475345ebd60053a4738a4c5268a
	vagrant@precise32:~$ yo -v
	1.1.2
	vagrant@precise32:~$ 
	

## How can I contribute ?

The first and foremost requirement to contribute is to have a BitBucket account, so as a first step please [register with BitBucket](https://bitbucket.org/).

> Currently, I do not plan to add other additional features to vagrant-webdev unless it is really value adding. 

As a result of the above guideline, there are two options available for you to contribute.

* __Branch__: If you are planning to fix a bug in the current code or in general improving the way things are implemented, you need to create a Branch. In case you are planning to add new features or packages please do __NOT__ create a Branch. I discuss branching in more detail below.
* __Fork__: If you intend to use vagrant-webdev as a base and then want to modify it (e.g. remove mongodb and add MySQL) or want to add additional packages then you need to create a Fork. That way none of the changes you make in your fork move to my repository, but there is a linkage maintained. You can continue working independently on your Fork which is identical to it's parent repository when you forked it.

### Branching Strategy.

I strongly recommend reading the following 

* [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
* [Branching chapter](https://www.atlassian.com/git/tutorial/git-branches)
* [Git Workflows chapter](https://www.atlassian.com/git/workflows)

before you proceed to contribute to the repository.

We are using a subset of the Git workflow that is suggested in the first post.

The following long running branches will be there in the repository

* __master__: This is the main branch, which will be cloned by most people who would want to use vagrant-webdev. As a result this should be extremely stable. No one should push code directly to master.
* __develop__: This is the development branch, or can also be called as our integration branch. All contributors are requested to create their own feature branch using develop as a base branch. Minor bug fixes can be directly submitted to develop.

In addition to the above long running branches, developers should create their own feature branches to track their development..

* __feature branches__: The feature branch is created by each developer to logically track individual features they are working on. The naming convention to follow for a feature branch is __name_FEATURE__. A single developer can have more than one feature branch, if they are contributing to multiple featured simultaneously.

The developer is first required to pull the latest changes from remote to local develop branch, then have a local merge from develop to feature branch. Once the merged feature branch is working as expected, push it to BitBucket and from there initiate a Pull request to get the feature branch merged into the remote develop branch.

After all the features are successfully merged into the develop branch, and everything is confirmed to be working, a pull request from the develop to master in remote will be initiated and that release will be tagged.

Post merge to develop all feature branches are to be deleted.


