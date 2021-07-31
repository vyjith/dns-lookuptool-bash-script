# dns-lookuptool-bash-script
[![Build](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

sudo apt -y install whois

Please note that this script only works on the linux machine

## **Description**
-------------------------------------------------- 

I think this script is very useful for the Linux support admin. In this script, you can check A, MX, PTR, WHOIS, and name server information. Another advantage of the script is that you can simply verify the domain registration points they host and so on. I'll share with you a demo of my script below. Please contact me if you encounter any problems running this script.

## Pre-Requestes (Packages Installation)
-------------------------------------------------- 
_For-RedHat-Distributer_

``` javascript 
sudo yum -y install git 
sudo yum -y install bind-utils
sudo yum -y install whois
```
 _For Debian-Distributer_
 
 ``` javascript 
sudo yum -y install git 
sudo yum -y install dnsutils
sudo yum -y install whois
```

>Please note that this script is not supporting with macOS and windows

-------------------------------------------------- 

## How to use this script

``` javascript 
git clone https://github.com/vyjith/dns-lookuptool-bash-script.git
cd dns-lookuptool-bash-script
chmod +x dt.sh
```
