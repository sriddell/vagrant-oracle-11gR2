#execute "Desktop" do 
#    command 'yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"'
#    user "root"
#end

node["oracle"]["db_packages"].each do |db_package|
  package db_package
end

execute "libaio.i686" do 
  command 'yum -y install libaio.i686'
  user "root"
end
execute "libaio-devel.i686" do 
  command 'yum -y install libaio-devel.i686'
  user "root"
end
execute "libstdc++-33.i686" do 
  command 'yum -y install libstdc++.i686'
  user "root"
end
execute "libgcc.i686" do
  command "yum -y install libgcc.i686"
  user "root"
end
execute "glibc-devel.i686" do 
  command "yum -y install glibc-devel.i686"
  user "root"
end
execute "compat-libstdc++.i686" do 
  command "yum -y install glibc-devel.i686"
  user "root"
end
execute "oracle packages" do 
  command "yum -y install zip unzip binutils compat-libstdc++-33 elfutils-libelf elfutils-libelf-devel glibc glibc-common glibc-devel gcc gcc-c++ libaio libaio-devel libgcc libstdc++ libstdc++-devel make sysstat unixODBC unixODBC.i686 unixODBC-devel unixODBC-devel.i686"
  user "root"
end

execute "/sbin/sysctl -p" do
  action :nothing
end

template "/etc/sysctl.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "sysctl.conf.erb"
  notifies :run, resources(:execute => "/sbin/sysctl -p")
end


#execute "swapoff -v /dev/VolGroup/lv_swap" do 
#  command "swapoff -v /dev/VolGroup/lv_swap"
#  user "root"
#end

#execute "lvm lvextend --size 1494MB /dev/VolGroup/lv_swap" do
#  command "lvm lvextend --size 1494MB /dev/VolGroup/lv_swap"
#  user "root"
#end

#execute "swapon -va" do 
#  command "swapon -va"
#  user "root"
#end

group "dba" do
  gid 200
  ignore_failure true
  #members 'oracle'
end

user "oracle" do
  comment "Oracle Service Account - DBA"
  uid 200
  gid "dba"
  home "/home/oracle"
  shell "/bin/bash"
  password "$1$DbPnQT1C$1ZNs9NXEYv0DNRbPEoaXJ1"
  #ignore_failure true
  supports :manage_home => true
end


template "/etc/security/limits.conf" do
  owner "root"
  group "root"
  mode "0644"
  source "limits.conf.erb"
end

include_recipe "oracle::install"

template "/root/zerofree.sh" do
  owner "root"
  group "root"
  mode "0755"
  source "zerofree.sh.erb"
end

execute "zerofree" do
  command "./zerofree.sh"
  cwd "/root"
  user "root"
end



