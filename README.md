# Ansible playbook for Ubuntu 20.04


##### useful commands....
##### generate ssh key localy for vagrant file

```
cd $HOME/.ssh
ssh-keygen -t ed25519
```
Ansisble gather facts
```
ansible -m setup all -i hosts.ini -u #some user
```

Ansible gather facts output to file

```
ansible -m setup all -i hosts.ini --tree out/ -u root
```

Ansible cmdb

```
ansible-cmdb -t html_fancy_split -p local_js=1 out/
```

Ansible Ping

```
ansible all -m ping -i ../../../Ansible-Inventory/localhosts 
```

run complete Ansible playbook with vault encryption and path to password file set path accordingly

```
ansible-playbook provision.yml --vault-password-file=/home/$USER/ansible-PASSWORDS/MYPASSWORD.txt -i hosts -u root 
```

run ansible playbook with tags

```
ansible-playbook provision.yml --vault-password-file=/home/$USER/ansible-PASSWORDS/MYPASSWORD.txt --tags "tag1,tag2,etc" -i hosts -u root 

ansible-playbook provision.yml --vault-password-file=/home/$USER/ansible-PASSWORDS/MYPASSWORD.txt --tags "tag1,tag2,etc" -i ../../../Ansible-Inventory/hosts
```

run ansible start at a certain task
```
ansible-playbook provision.yml --vault-password-file=/home/$USER/ansible-PASSWORDS/MYPASSWORD.txt --start-at-task="This is the task name" -i hosts -u root

ansible-playbook provision.yml --vault-password-file=/home/$USER/ansible-PASSWORDS/MYPASSWORD.txt --start-at-task="This is the task name" 
```
