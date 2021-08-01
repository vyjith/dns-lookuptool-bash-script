# DNS lookup script
  
  [![ng-remote-logging](https://snyk.io/advisor/npm-package/ng-remote-logging/badge.svg)](https://snyk.io/advisor/npm-package/ng-remote-logging)
  
## **Description**
-------------------------------------------------- 

I think this script is very useful for the Linux support admin. In this script, you can check A, MX, PTR, WHOIS, and NAMESERVER information. Another advantage of the script is that you can simply verify the domain registration points they host and so on. I'll share with you a demo of my script below. Please contact me if you encounter any problems running this script.

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
geekflare.com.          84292   IN      NS      olga.ns.cloudflare.com.
geekflare.com.          84292   IN      NS      todd.ns.cloudflare.com.

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

Mail IP is: 142.250.113.27

The geekflare.com MX record is pointing to:  Google LLC

 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  TXT record result of the geekflare.com
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

geekflare.com.          300     IN      TXT     "google-site-verification=MRSwa454qay1S6pwwixzoiZl08kfJfkhiQIslhok3-A"
geekflare.com.          300     IN      TXT     "google-site-verification=7QXbgb492Y5NVyWzSAgAScfUV3XIAGTKKZfdpCvcaGM"
geekflare.com.          300     IN      TXT     "yandex-verification: 42f25bad396e79f5"
geekflare.com.          300     IN      TXT     "v=spf1 include:_spf.google.com include:mailgun.org ~all"
geekflare.com.          300     IN      TXT     "ahrefs-site-verification_8eefbd2fe43a8728b6fd14a393e2aff77b671e41615d2c1c6fc365ec33a4d6d0"
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  PTR record of the 104.27.118.115
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

```
## Behind the code
```sh
#! /bin/bash

domain_name=$1
if [ -n "$domain_name" ]
then
        echo
        echo -e "\e[32m\e[1m  Thank you for entering the domain name\e[0m"
        echo
        if grep -oP '^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,6}$' <<< "$domain_name" >/dev/null 2>&1;
        then
                # domain dns information is the following
                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  Dig result of the $domain_name"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo
        dig +nocmd $domain_name a +noall +answer >> ~/digresult
        dig +nocmd $domain_name ns +noall +answer >> ~/digresult
        cat ~/digresult| sort | sort -u -k 5 && rm -rf ~/digresult
        echo
        IPS=`dig +nocmd $domain_name a +noall +answer | grep ^"$domain_name" | grep A | awk {'print $5'} | head -n1`
        echo "The $domain_name A record is pointing to : " `whois $IPS 2>&1 | grep -i "OrgName" | cut -d ":" -f2`
        echo
        echo "The $domain_name "`/usr/bin/curl -I $domain_name 2>&1 | grep -E "Server:"`
        echo

# MX record of the domain
                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  MX record result of the $domain_name"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo
        dig +nocmd $domain_name mx +noall +answer
        echo
        MX=`dig +nocmd $domain_name mx +noall +answer | grep ^"$domain_name" | grep MX | awk {'print $6'} | rev | cut -c2- | rev | head -n1`
        echo "Mail IP is:" `dig $MX a +short`
        Who=`dig $MX +short`
        echo
        echo "The $domain_name MX record is pointing to: " `whois $Who 2>&1 | grep -i "OrgName" | cut -d ":" -f2`
echo
# TXT record fo the domain

                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  TXT record result of the $domain_name"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo
        dig +nocmd $domain_name txt +noall +answer
#PTR record of the domain
        IP=`dig +nocmd $domain_name a +noall +answer | grep ^"$domain_name" | grep A | awk {'print $5'} | head -n1`
                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  PTR record of the $IP"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo
        dig -x $IP +noall +answer | grep -vE ^";|^$"
echo
#WHOIS record of the domain

echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  Whois informaion of the $domain_name"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"

        whois $domain_name | grep -E "Registrar:|Registry Expiry Date:|Registrar URL:|Name Server:|Expiration Date:|URL:"
echo
echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
        else
                echo -e "\e[31m\e[1mPlease enter a FQDN domain like ('Google.com). Also, don't use protocol (http://,https://) and symbol's\e[0m"
        fi
else
        echo -e "\e[31m\e[1mOops!! You didn't give any input. Please give the domain name. \e[0m"
fi

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


