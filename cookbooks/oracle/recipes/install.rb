directory "/home/oracle/oracle" do
  owner "oracle"
  group "dba"
  recursive true
end

cookbook_file "linux.x64_11gR2_database_1of2.zip" do 
  path "/home/oracle/oracle/linux.x64_11gR2_database_1of2.zip"
end

cookbook_file "linux.x64_11gR2_database_2of2.zip" do 
  path "/home/oracle/oracle/linux.x64_11gR2_database_2of2.zip"
end

execute "unzip1" do 
  command "unzip linux.x64_11gR2_database_1of2.zip && unzip linux.x64_11gR2_database_2of2.zip"
  user "oracle"
  cwd "/home/oracle/oracle"
end

template "/etc/oraInst.loc" do
  mode "0644"
  owner "root"
  group "root"
  source "oraInst.loc.erb"
end

template "/home/oracle/db.rsp" do 
  owner "oracle"
  group "dba"
  source "db.rsp.erb"
end

directory "/u01/app/" do
  owner "oracle"
  group "dba"
  recursive true
end

directory "/u01/app/oracle" do
  owner "oracle"
  group "dba"
  recursive true
end

#need to wrap this to get it to run in a login shell like environment
execute "install" do 
  command "su -l -c 'cd /home/oracle/oracle/database && ./runInstaller -ignoreSysPrereqs -silent -noconfig -responseFile /home/oracle/db.rsp -waitforcompletion' oracle"
  user "root"
  returns [0, 253]
end

execute "root.sh" do 
  command "/u01/app/oracle/product/11.2.0/dbhome_1/root.sh"
  user "root"
end

directory "/home/oracle/oracle" do
  action :delete
end