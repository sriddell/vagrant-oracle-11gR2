directory "/home/oracle/oracle" do
  owner "oracle"
  group "dba"
  recursive true
end

remote_directory "/home/oracle/oracle" do
  files_owner 'oracle'
  owner 'oracle'
  source "oracle"
end

execute "unzip1" do
  command "unzip \\*.zip"
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
  returns [0, 6]
end

execute "root.sh" do
  command "/u01/app/oracle/product/11.2.0/dbhome_1/root.sh"
  user "root"
end

directory "/home/oracle/oracle" do
  action :delete
  recursive true
end