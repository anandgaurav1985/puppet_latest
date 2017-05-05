# Class: openssh
# ===========================
#
# Full description of class openssh here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'openssh':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class openssh {
#using case statement 
#case $::operatingsystem {
#'CentOS':{ $pk='openssh-server' }
#'Solaris':{ $pk='openssh' }
#}

#using selector
#$pk=$operatingsystem ? {
#'CentOS'=>'openssh-server',
#'Solaris'=>'openssh',
#}

#using if statement
if $::operatingsystem=='CentOS' {
$pk='openssh-server'
}
#elsif $::operatingsystem=='Solaris' {
#$pk='openssh-server'
#}
#else {
#notify{"operatingsystem not found":}
#}

package{"$openssh::pk":
#name=>"$pk",
ensure=>'present',
provider=>'yum',
}
package{'git':
ensure=>'installed',
}

file{'/etc/ssh/sshd_config':
ensure=>'present',
owner=>'root',
group=>'root',
mode=>'600',
source=>'puppet:///modules/openssh/sshd_config',
require=>Package['openssh-server'],
}
service{'sshd':
ensure=>'running',
hasstatus=>'true',
hasrestart=>'true',
require=>File['/etc/ssh/sshd_config'],
subscribe=>File['/etc/ssh/sshd_config'],
}
}
