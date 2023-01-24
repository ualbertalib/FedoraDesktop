# To Do list

## EDITOR setting

* Perhaps this should be a variable set in inventory? 
* Set this in both ~/.bashrc, and in /root/.bashrc, please
* And use it in the prep-script, so the *right* editor is set, for each person

## JMeter

* This has been useful for loadtesting applications
* See: [https://jmeter.apache.org/download_jmeter.cgi](https://jmeter.apache.org/download_jmeter.cgi)
* They use mirror sites, obfuscating the download. Mirror site only seems to contain the most recent version? 
* Unlike other projects, there's no static link to the current version. 
* We'd have to parse the download page above, & extract a link. Seems like too much work; their page fragile? 
* I think we're stuck with a manual install ... ? 

```
 cd ~
 pushd /tmp/
      wget http://apache.mirror.gtcomm.net//jmeter/binaries/apache-jmeter-5.2.1.tgz   # but that version number will change over time... perhaps an Ansible variable to control 
      wget https://www.apache.org/dist/jmeter/binaries/apache-jmeter-5.2.1.tgz.sha512
      ssha512sum --check apache-jmeter-5.2.1.tgz.sha512 ha512sum 
      (read results)
 popd
 mkdir bin
 pushd bin
      tar xzf /tmp/apache-jmeter-5.2.1.tgz
 popd
```

* Further manual steps: edit ~/.bashrc & 
   a) append ~/bin/apache-jmeter-5.2.1/bin to $PATH
   b) Set $JAVA_HOME to something like: 
        export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0.fc31.x86_64/jre


## Propose copying everything under ~/dev from the old machine

* Should we maintain a list of interesting repos & install them for everyone... eg Critical apps? 

## Sharing this Repo

* Figure out a way to extract the security-sensitive parts of this playbook (encrypted vars; passwords; SSH keys, etc) from this repo, into something that's easy to transport.  "git submodule"? 
 
