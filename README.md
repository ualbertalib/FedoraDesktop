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

## Step 1: Perform OS install

* Use the Workstation-Live ISO
* Perform fresh OS install & reboot (get the right time zone)
* At "firstboot", 
    * please set the root password (security!) & don't enable remote login by root
    * enable the optional repositories 
    * set up your personal account
* Install all the latest patches with: `sudo dnf update -y` (or use the "software" GUI) and reboot

## Step 2: Get a copy of the toolkit

* On the freshly installed VM, logged in with your personal userid...
* Install git; `sudo dnf install git`
* Clone this repo, I suggest: `mkdir ~/dev/; cd ~/dev; git clone https://github.com/ualbertalib/FedoraDesktop.git; cd FedoraDesktop`  (It's public, you shouldn't need any keys)

## Step 3: Personalize the toolkit

* Add your SSH key files into the tree
    * If this is your first time, generate a new keypair; otherwise, copy existing files to this machine; if you generate new, consider how you'll back these up!
    * `cp ~/.ssh/id* ~/dev/FedoraDesktop/roles/desktop/files/`   # Neil, this is redundant
    * (you must not commit them to this repo; .gitignore is set up to ignore these files)
* Edit roles/desktop/files/authorized_keys, adding the public key(s) you want to use for remotely logging into your desktop
* roles/desktop/vars/main-template.yml is unencrypted, but we'll use it to create  a place where you should put your passwords
    * `cd roles/desktop/vars`
    * `cp main-template.yml main.yml`
    * `ansible-vault encrypt main.yml`  --> it will prompt you twice for a password
    * `ansible-vault edit main.yml` --> it wants the password now.   Add your passwords!
    * It's worth saying: you must not commit these credentials!
* This file: inventory.template
    * Make your own copy you can edit: `cp inventory.template inventory`
    * You should edit "inventory" & make sure the canonical hostname of this VM is the only entry in the [desktop] group
    * Fill out the variables found there!  I'm not kidding !  This step is very important! (set your userid)

## Step 4: The main event - Use scripts and Ansible to configure the desktop

* run the prepNewDesktop4Ansible.sh script, directly on the fresh OS 
* Run the playbook that will configure the machine, ready to be your desktop:

`ansible-playbook desktop.yml -i inventory --ask-vault-pass `  # wants password for decryption
