# librarian-puppet would have downloaded and installed the required modules
# now is the time to use them to install the required applications

# Set path for exec
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


# Include apt first
class { 'apt':
	always_apt_update => false,
}


# add repos
apt::ppa { 'ppa:webupd8team/java': }   # Oracle JDK 6/7/8
apt::ppa { 'ppa:natecarlson/maven3': } # Apache Maven 3
apt::ppa { 'ppa:chris-lea/node.js': }  # nodejs


# apt update
exec { 'apt-update':
	command 	=> 'apt-get update',
}


# Manage Oracle license
exec { 'set-license-selected':
		command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections',
}
package { 'oracle-java7-installer':
  ensure  	=> 'installed',
  require  	=> Exec['set-license-selected'],  # ensure license is handled 
}
package { 'oracle-java7-set-default':
	ensure 		=> 'installed',
}
# Ensure Java ppa is added and then install the two packages
Apt::Ppa['ppa:webupd8team/java'] -> Package['oracle-java7-installer'] -> Package['oracle-java7-set-default'] 


# Install Maven after Oracle JDK 
package { 'maven3':
  ensure  	=> 'installed',
  require 	=> Package['oracle-java7-set-default'],
}
# Create Maven symlink
file { 'mvn_symlink':
	path 			=> '/usr/bin/mvn',
	ensure 		=> 'link',
	target 		=> '/usr/bin/mvn3',
}
# Setup Maven environment variable files for all users
file { 'mvn.sh':
	ensure 		=> 'file',
	path 			=> '/etc/profile.d/mvn.sh',
	mode			=> 0644,
	content		=> 'export M2_HOME=/usr/share/maven3
export M2=$M2_HOME/bin
export PATH=$PATH:$M2
',
}
# Ensure maven ppa is added and JDK installed. Then proceed to set symlink and env vars
Apt::Ppa['ppa:natecarlson/maven3'] -> Package['maven3'] -> File['mvn_symlink'] -> File['mvn.sh']


# Install nodejs, yeoman, grunt cli and bower
package { 'nodejs':
  ensure  	=> 'installed',
}
# Install yeoman (since our npm version is > 1.2.10 we do not need to install grunt-cli and bower explicitly
exec { 'install-yo':
  command 	=> 'npm -g install yo',
}
#Ensure nodejs ppa is added befre trying to install nodejs and yeoman9
Apt::Ppa['ppa:chris-lea/node.js'] -> Exec['apt-update'] -> Package['nodejs'] -> Exec['install-yo']


#Install mongodb
class {'::mongodb::globals':
  manage_package_repo => true,
}
class {'::mongodb::server': }
class {'::mongodb::client': }
Class['::mongodb::globals'] -> Class['::mongodb::server'] -> Class['::mongodb::client']

