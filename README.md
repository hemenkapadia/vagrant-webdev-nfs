## What is vagrant-webdev ?

vagrant-webdev is a [Vagrant](http://www.vagrantup.com) based development box that can be used to quickly set-up a web development box.

## What constitutes the development stack ?

The following forms the development stack

1. Ubuntu 14.04 (Trusty Thar) 32 bit base box.  (Referred to as `GUEST` throughout the document)
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

> Note - If your `HOST` system is Linux or Mac OSX, I strongly recommend you to use [vagrant-webdev-nfs](https://bitbucket.org/hemenkapadiapublic/vagrant-webdev-nfs) repository. It uses nfs to overcome performance issues with virtualbox shared folders, used by vagrant-webdev. A Windows `HOST` does not seem to have this issue.

To know more about NFS performance read

1. [Use NFS to speed up your Vagrant ](https://coderwall.com/p/uaohzg)
2. [NFS shared folders](http://friendsofvagrant.github.io/v1/docs/nfs.html)

I also assume a directory structure as follows. So go ahead and create one as mentioned below

	| Your home directory
	|--- projects
	|------ vagrant-webdev-workspace
	|------ vagrant-webdev-m2

> vagrant-webdev-workspace and vagrant-webdev-m2 are important shared folders between your `GUEST` and `HOST`. Workspace folder will contain our development code, such that you can use tools that you are comfortable with (IDE, Browser etc.) that are already installed on your `HOST` for development and testing, but use the `GUEST` for build and deployment. M2 folder is your maven repository, needed for depedency resolution in your IDE on `GUEST`.

### Step 2. Clone the BitBucket repository

Follow these commands to clone the vagrant-webdev repository on the `HOST`

	cd ~
	cd projects
	git clone https://hemenkapadia@bitbucket.org/hemenkapadiapublic/vagrant-webdev.git

This will clone the vagrant-webdev code from git on your machine and your directory structure would look like 

	| Your home directory
	|--- projects
	|------ vagrant-webdev-workspace
	|------ vagrant-webdev-m2
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

	hekapadi@HEKAPADI-W7-1 ~/Workspaces/Personal/vagrant-webdev (develop)
	$ vagrant ssh
	Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-30-generic i686)

	 * Documentation:  https://help.ubuntu.com/

	 System information disabled due to load higher than 1.0

		Get cloud support with Ubuntu Advantage Cloud Guest:
			http://www.ubuntu.com/business/services/cloud

	0 packages can be updated.
	0 updates are security updates.


	vagrant@vagrant-ubuntu-trusty-32:~$

Notice the change in the prompt. It indicates that you are now on the `HOST` box.

I use the following commands to ensure vagrant-webdev has been provisioned correctly. Verify once your machine is up too.

	vagrant@vagrant-ubuntu-trusty-32:~$ java -version
	java version "1.7.0_60"
	Java(TM) SE Runtime Environment (build 1.7.0_60-b19)
	Java HotSpot(TM) Client VM (build 24.60-b09, mixed mode)
	vagrant@vagrant-ubuntu-trusty-32:~$ mvn -version
	Apache Maven 3.0.5
	Maven home: /usr/share/maven
	Java version: 1.7.0_60, vendor: Oracle Corporation
	Java home: /usr/lib/jvm/java-7-oracle/jre
	Default locale: en_US, platform encoding: UTF-8
	OS name: "linux", version: "3.13.0-30-generic", arch: "i386", family: "unix"
	vagrant@vagrant-ubuntu-trusty-32:~$ mongod -version
	db version v2.4.10
	Wed Jul  2 17:10:54.326 git version: e3d78955d181e475345ebd60053a4738a4c5268a
	vagrant@vagrant-ubuntu-trusty-32:~$ mongo -version
	MongoDB shell version: 2.4.10
	vagrant@vagrant-ubuntu-trusty-32:~$ node -v
	v0.10.29
	vagrant@vagrant-ubuntu-trusty-32:~$ npm -v
	1.4.14
	vagrant@vagrant-ubuntu-trusty-32:~$ yo -v
	[?] ==========================================================================
	We're constantly looking for ways to make yo better!
	May we anonymously report usage statistics to improve the tool over time?
	More info: https://github.com/yeoman/insight & http://yeoman.io
	==========================================================================: No
	1.2.0
	vagrant@vagrant-ubuntu-trusty-32:~$ env | grep java
	DERBY_HOME=/usr/lib/jvm/java-7-oracle/db
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-7-oracle/bin:/usr/
	lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin
	JAVA_HOME=/usr/lib/jvm/java-7-oracle
	NODE_PATH=/usr/lib/nodejs:/usr/lib/node_modules:/usr/share/javascript
	J2SDKDIR=/usr/lib/jvm/java-7-oracle
	J2REDIR=/usr/lib/jvm/java-7-oracle/jre
	vagrant@vagrant-ubuntu-trusty-32:~$ env | grep maven
	vagrant@vagrant-ubuntu-trusty-32:~$
	
  
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
* __develop__: This is the development branch, or can also be called as our integration branch. The develop branch will form the base for any feature branches created. Only Minor bug fixes can be directly submitted to develop. Do not submit features directly to the develop branch. Use the feature branch instead. The develop branch is used to integrate various features being developed simultaneously in the features branches.

In addition to the above long running branches, developers should create their own feature branches to track their development..

* __feature branches__: A single feature branch is created to logically track an individual feature being developed, on which multiple developers could be working. The naming convention to follow for a feature branch is __FEATURE_NAME__. A single developer can work on more than one feature. I suggest each developer follow the below process to contribute to features.

1. Create a new feature branch (if one does not exist) or if someone has already created one on the remote, get it locally.
2. Ensure you pull the latest changes from this remote feature branch to your local feature branch periodically (typically every couple of days).
3. If the pull results in a conflict, ensure that you resolve the same in the local feature branch.
4. Periodically also pull the latest develop branch for any bug fixes that have been made to it.
5. Merge the bug fixes from local develop to your local feature branch.
6. At this point you local feature branch should contain all bug fixes made to develop, any changes made by other developers to the feature branch, and your changes to the feature branch.
7. Ensure that the code builds correctly and all test cases pass.
8. If all looks good, commit your changes to your local feature branch and then push those changes to the remote feature branch.
9. Request that the feature be included in the develop branch by initiating a pull request.


After multiple features are successfully merged into the develop branch, and everything is confirmed to be working, a pull request from the develop to master in remote will be initiated and that release will be tagged.

The feature branches will be deleted once they are merged into develop.


