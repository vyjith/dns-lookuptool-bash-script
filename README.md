# DNS lookup script
[![Builds](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

  
## **Description** -test
-------------------------------------------------- 

I think this script is very useful for the Linux support admin's. In this script, you can check A, MX, PTR, WHOIS, and NAMESERVER information. Another advantage of the script is that you can simply verify the domain registration points they host and so on. I'll share with you a demo of my script below. Please contact me if you encounter any problems running this script.

## Pre-Requestes (Packages Installation)
-------------------------------------------------- 
_For-RedHat-Distributer_

``` javascript 
sudo yum -y install git 
sudo yum -y install bind-utils
sudo yum -y install curl
sudo yum -y install whois
```
 _For Debian-Distributer_
 
 ``` javascript 
sudo yum -y install git 
sudo yum -y install dnsutils
sudo yum -y install curl
sudo yum -y install whois
```

>Please note that this script is not supporting with macOS and windows

-------------------------------------------------- 


## How to use this script

``` javascript 
git clone https://github.com/vyjith/dns-lookuptool-bash-script.git
cd dns-lookuptool-bash-script
chmod +x di.sh
```
_Alias Assgning for this script_
``` javascript 
echo "alias dg='bash $(pwd)/di.sh'" >> ~/.bashrc
source ~/.bashrc
```

## Script Running
``` javascript 
dg geekflare.com
or 
bash di.sh geekflare.com
``` 

## Output

``` javascript 
# dg geekflare.com

  Thank you for entering the domain name

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Dig result of the geekflare.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

geekflare.com.          30      IN      A       104.27.118.115
geekflare.com.          30      IN      A       104.27.119.115
geekflare.com.          86400   IN      NS      olga.ns.cloudflare.com.
geekflare.com.          86400   IN      NS      todd.ns.cloudflare.com.

The geekflare.com A record is pointing to :  Cloudflare, Inc.

The geekflare.com Server: cloudflare

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  MX record result of the geekflare.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

geekflare.com.          300     IN      MX      1 aspmx.l.google.com.
geekflare.com.          300     IN      MX      5 alt1.aspmx.l.google.com.
geekflare.com.          300     IN      MX      5 alt2.aspmx.l.google.com.
geekflare.com.          300     IN      MX      10 alt3.aspmx.l.google.com.
geekflare.com.          300     IN      MX      10 alt4.aspmx.l.google.com.

Mail IP is: 142.250.112.26

The geekflare.com MX record is pointing to:  Google LLC

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  TXT record result of the geekflare.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

geekflare.com.          300     IN      TXT     "google-site-verification=MRSwa454qay1S6pwwixzoiZl08kfJfkhiQIslhok3-A"
geekflare.com.          300     IN      TXT     "google-site-verification=7QXbgb492Y5NVyWzSAgAScfUV3XIAGTKKZfdpCvcaGM"
geekflare.com.          300     IN      TXT     "yandex-verification: 42f25bad396e79f5"
geekflare.com.          300     IN      TXT     "v=spf1 include:_spf.google.com include:mailgun.org include:zcsend.net ~all"
geekflare.com.          300     IN      TXT     "ahrefs-site-verification_8eefbd2fe43a8728b6fd14a393e2aff77b671e41615d2c1c6fc365ec33a4d6d0"
geekflare.com.          300     IN      TXT     "ca3-7fbfaa573ba248ddb17a618e5b46ca01"
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  PTR record of the 104.27.119.115
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Whois informaion of the geekflare.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Registrar URL: http://www.cloudflare.com
   Registry Expiry Date: 2025-01-07T14:14:12Z
   Registrar: CloudFlare, Inc.
   Name Server: OLGA.NS.CLOUDFLARE.COM
   Name Server: TODD.NS.CLOUDFLARE.COM

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Here we are just comparing the nameserver info in the DNS zone and Whois
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Nameserver details geekflare.com in DNS zone
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

   NameServer :  olga.ns.cloudflare.com.
   NameServer :  todd.ns.cloudflare.com.

   The 108.162.192.137 is Pointing to : Cloudflare, Inc.
   The 173.245.58.137 is Pointing to : Cloudflare, Inc.
   The 172.64.32.137 is Pointing to : Cloudflare, Inc.
   The 172.64.33.146 is Pointing to : Cloudflare, Inc.
   The 108.162.193.146 is Pointing to : Cloudflare, Inc.
   The 173.245.59.146 is Pointing to : Cloudflare, Inc.

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Nameserver details geekflare.com in whois
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

   Name Server: OLGA.NS.CLOUDFLARE.COM
   Name Server: TODD.NS.CLOUDFLARE.COM

   The 173.245.58.137 is Pointing to : Cloudflare, Inc.
   The 108.162.192.137 is Pointing to : Cloudflare, Inc.
   The 172.64.32.137 is Pointing to : Cloudflare, Inc.
   The 172.64.33.146 is Pointing to : Cloudflare, Inc.
   The 108.162.193.146 is Pointing to : Cloudflare, Inc.
   The 173.245.59.146 is Pointing to : Cloudflare, Inc.


```
### Used commands

- _dig_
- _whois_
- _curl_

## Conclusion

It is a simple bash script to verify domain DNS information with one click. Please contact me when you encounter any difficulty error while running this script. Thank you!

### ⚙️ Connect with Me
<p align="center">
<a href="https://www.instagram.com/iamvyjith/"><img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white"/></a>
<a href="https://www.linkedin.com/in/vyjith-ks-3bb8b7173/"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/></a>


