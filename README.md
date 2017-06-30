![Imgur](http://i.imgur.com/kwW7v1C.png?1)


# Minotauro Vagrant Rails


```
A Virtual Machine for Ruby on Rails Application Development
```

## Introduction

This project automates the setup of a development environment for general Ruby on Rails application development.

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* [Ansible](http://www.ansible.com/home)



## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/pragmaticivan/minotauro_vagrant_rails.git
    host $ cd minotauro_vagrant_rails
    host $ vagrant up

If the base box is not present that command fetches it first.

    host $ vagrant ssh
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)
    ...
    vagrant@minotaurorailsbox:~$

Port 3000 in the host computer is forwarded to port 3000 in the virtual machine. This, applications running in the virtual machine can be accessed via localhost:3000 in the host computer.

## What's In The Box

* MySQL
* PostgreSQL
* RVM
* MongoDB
* Redis
* Elasticsearch

## Recommended Workflow

The recommended workflow is

* edit files in the host computer

* run within the virtual machine

* If you're using rails with version 4+, you should specify the hostname to 0.0.0.0 (ex: `rails s -b 0.0.0.0`)

## Database
* For mysql the default user is root: `mysql -u root`
* For postgresql the default user is `minotauro` and the password is `minotauro`



## Virtual Machine Management

When done just log out with and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.
