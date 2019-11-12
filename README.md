# amaze_pdns

Generate Policyfile export:
```sh
# chef install Policyfile.rb
Building policy amaze_pdns
Expanded run list: recipe[amaze_pdns::default]
Caching Cookbooks...
Installing amaze_pdns >= 0.0.0 from path
Using      postgresql 7.1.4

Lockfile written to /Users/kris/Documents/Source/amaze_pdns/Policyfile.lock.json
Policy revision id: 580256e2f18d5bcf085303320b3b74b243016ae0855f197027ee3e7286f5760f
# chef export Policyfile.rb /tmp/amaze_pdns
Exported policy 'amaze_pdns' to /tmp/amaze_pdns

To converge this system with the exported policy, run:
  cd /tmp/amaze_pdns
  chef-client -z
# cd /tmp; tar -czf amaze_pdns.tgz amaze_pdns
```

Apply to fresh install:
```sh
# curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 14
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 23248  100 23248    0     0  18436      0  0:00:01  0:00:01 --:--:-- 18421
debian 10 x86_64
Getting information for chef stable 14 for debian...
downloading https://omnitruck.chef.io/stable/chef/metadata?v=14&p=debian&pv=10&m=x86_64
  to file /tmp/install.sh.13584/metadata.txt
trying wget...
sha1	367d51128bbee7e047d3e4ac608f97e5ac3dd59b
sha256	9a4c3881cbe5763517be52287a66f62095e89a4d80b4642ace56809bbff5841a
url	https://packages.chef.io/files/stable/chef/14.14.29/debian/9/chef_14.14.29-1_amd64.deb
version	14.14.29
downloaded metadata file looks valid...
downloading https://packages.chef.io/files/stable/chef/14.14.29/debian/9/chef_14.14.29-1_amd64.deb
  to file /tmp/install.sh.13584/chef_14.14.29-1_amd64.deb
trying wget...
Comparing checksum with sha256sum...
Installing chef 14
installing with dpkg...
Selecting previously unselected package chef.
(Reading database ... 100649 files and directories currently installed.)
Preparing to unpack .../chef_14.14.29-1_amd64.deb ...
Unpacking chef (14.14.29-1) ...
Setting up chef (14.14.29-1) ...
Thank you for installing Chef Infra Client! For help getting started visit https://learn.chef.io
# wget https://github.com/AmazeCom/amaze_pdns/releases/download/v0.0.1-alpha/amaze_pdns.tgz
--2019-11-13 08:20:02--  https://github.com/AmazeCom/amaze_pdns/releases/download/v0.0.1-alpha/amaze_pdns.tgz
Resolving github.com (github.com)... 13.236.229.21
Connecting to github.com (github.com)|13.236.229.21|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22581 (22K) [application/octet-stream]
Saving to: ‘amaze_pdns.tgz’

amaze_pdns.tgz   100%[============================================================>]  22.05K   105KB/s    in 0.2s    

2019-11-13 08:20:03 (105 KB/s) - ‘amaze_pdns.tgz’ saved [22581/22581]
# tar xzf amaze_pdns.tgz
# cd amaze_pdns
# chef-client -z
Starting Chef Client, version 14.14.29
Using policy 'amaze_pdns' at revision '580256e2f18d5bcf085303320b3b74b243016ae0855f197027ee3e7286f5760f'
resolving cookbooks for run list: ["amaze_pdns::default@0.1.0 (414dd72)"]
Synchronizing Cookbooks:
  - amaze_pdns (0.1.0)
  - postgresql (7.1.4)
Installing Cookbook Gems:
Compiling Cookbooks...
Converging 18 resources
...
```
