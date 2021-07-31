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
_Alias Assgning for this script_
``` javascript 
echo "alias dg='bash $(pwd)/di.sh'" >> ~/.bashrc
source ~/.bashrc
```

## Script Running
``` javascript 
dg facebook.com
or 
bash dt.sh facebook.com
``` 

## Output

``` javascript 
# dg facebook.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        Dig result of the facebook.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

facebook.com.           84      IN      A       157.240.2.35
facebook.com.           160430  IN      NS      a.ns.facebook.com.
facebook.com.           160430  IN      NS      b.ns.facebook.com.
facebook.com.           160430  IN      NS      c.ns.facebook.com.
facebook.com.           160430  IN      NS      d.ns.facebook.com.

The facebook.com A record is pointing to :  Facebook, Inc.

The facebook.com

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        MX record result of the facebook.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

facebook.com.           1682    IN      MX      10 smtpin.vvv.facebook.com.

Mail IP is: 173.252.127.251

The facebook.com MX record is pointing to:  Facebook, Inc.

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        TXT record result of the facebook.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

facebook.com.           85350   IN      TXT     "v=spf1 redirect=_spf.facebook.com"
facebook.com.           6150    IN      TXT     "google-site-verification=A2WZWCNQHrGV_TWwKh6KHY90tY0SHZo_RnyMJoDaG0s"
facebook.com.           6150    IN      TXT     "google-site-verification=wdH5DTJTc9AYNwVunSVFeK0hYDGUIEOGb-RReU6pJlY"
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        PTR record of the 157.240.2.35
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

35.2.240.157.in-addr.arpa. 3600 IN      PTR     edge-star-mini-shv-01-ort2.facebook.com.

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        Whois informaion of the facebook.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Registrar URL: http://www.registrarsafe.com
   Registry Expiry Date: 2028-03-30T04:00:00Z
   Registrar: RegistrarSafe, LLC
   Name Server: A.NS.FACEBOOK.COM
   Name Server: B.NS.FACEBOOK.COM
   Name Server: C.NS.FACEBOOK.COM
   Name Server: D.NS.FACEBOOK.COM

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
```


