# UAL toolkit for configuring a freshly-installed Fedora Desktop (or laptop, or VM)

* Fedora releases new versions every 6 months.  Rebuilding and re-customizing your desktop frequently can be a pain.
* Neil built this to ease the pain, by automating a lot of the work
* This is only tested for Fedora 37 - it probably won't work for any other version (but, I've tried to make porting easy)

## My assumptions for a desktop/laptop at UAL:

* I work with a lot of git repos.  I keep them all in a flat directory, ~/dev/.  
* It's going to help if your AD userid == local unix userid == CCID

## Updating?

* This repo assumes that you will nuke-and-pave the OS, then use this to recreate your desired configuration afresh.  If you're doing something else, this might not work for you.
* Before nuke-and-pave, know that this repo is missing key elements
    * backups (esp. of your home dir)
    * backups: your ~/.ssh/  (private keys)
    * backups: your ~/.config/
    * backups: your ~/.gitconfig/
    * backups: your ~/.vimrc/ (if you're a vim fan)
    * Engage brain!  What else is on that HD that you'll want right after you nuke it?

## Pre-amble: How to START using the toolkit to build *YOUR* system

* On the freshly installed VM, logged in with your personal userid...
* Install git; `dnf install git`
* Clone this repo, I suggest: `mkdir ~/dev/; cd ~/dev; git clone ...; cd FedoraDesktop`

## Customize the toolkit!

* Add your SSH key files to roles/files/ 
    * If this is your first time, generate a new keypair; copy them to ~/dev/DestopFedora/roles/desktop/files/
    * (you must not commit them to this repo; you need a plan for keeping these backed up)
    * 
* Edit roles/desktop/files/authorized_keys/, adding the public key(s) you want to use for remotely logging into your desktop
* roles/desktop/vars/main.yml is unencrypted, but this is the place where you should put your passwords, so it needs to be encrypted
    * `cd roles/desktop/vars`
    * `ansible-vault encrypt main.yml`  --> it will prompt you twice for a password
    * `ansible-vault edit main.yml` --> it wants the password now.   Add your passwords!
    * It's worth saying: you must not commit these credentials!
* This file: inventory.template
    * Make your own copy you can edit: `cp inventory.template inventory`
    * You should edit "inventory" & make sure the canonical hostname of this VM is the only entry in the [desktop] group
    * Fill out the variables found there!  I'm not kidding !  This step is very important! (set your userid)

## The main event - Steps to building and configuring your desktop

1. Perform fresh OS install & reboot (get the right time zone).
2. At "firstboot", 
    * please set the root password (security!) & don't enable remote login by root
    * enable the optional repositories 
    * set up your personal account
3. Install all the latest patches with: `dnf update -y` (or use the "software" GUI)
4. Use the prepNewDesktop4Ansible.sh script, directly on the fresh OS 
5. review inventory file, "prod" 
6. Run the playbook that will configure the machine, ready to be your desktop:

`ansible-playbook desktop.yml -i prod --ask-vault-pass --limit <u-pick-the-hostname>`


