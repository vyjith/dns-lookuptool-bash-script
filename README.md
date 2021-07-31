# DNS lookup script
:+1: I beilve this is good script for Linux admin  :shipit:


## **Description**
-------------------------------------------------- 

I think this script is very useful for the Linux support admin. In this script, you can check A, MX, PTR, WHOIS, and NAME SERVER information. Another advantage of the script is that you can simply verify the domain registration points they host and so on. I'll share with you a demo of my script below. Please contact me if you encounter any problems running this script.

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
## Behind the code
```sh
#! /bin/bash

domain=$1
if [ -z "$domain" ]
then
        echo "Please enter a FQDN. eg:('facebook.com')"
        exit 1
elif [[ "$domain" =~ ^http//* ]] || [[ "$domain" =~ ^https//* ]]
then
        echo "Please enter the domain a FQDN without protocol and symbol. eg:('facebook.com')"
        exit 1
elif grep -oP '^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,6}$' <<< "$domain" >/dev/null 2>&1;
then
# domain dns information is the following
                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  Dig result of the $domain"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo
        dig +nocmd $domain a +noall +answer >> ~/digresult
        dig +nocmd $domain ns +noall +answer >> ~/digresult
        cat ~/digresult| sort | sort -u -k 5 && rm -rf ~/digresult
        echo
        IPS=`dig +nocmd $domain a +noall +answer | grep ^"$domain" | grep A | awk {'print $5'} | head -n1`
        echo "The $domain A record is pointing to : " `whois $IPS 2>&1 | grep -i "OrgName" | cut -d ":" -f2`
        echo
        echo "The $domain "`/usr/bin/curl -I $domain 2>&1 | grep -E "Server:"`
        echo

# MX record of the domain
                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  MX record result of the $domain"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo
        dig +nocmd $domain mx +noall +answer
        echo
        MX=`dig +nocmd $domain mx +noall +answer | grep ^"$domain" | grep MX | awk {'print $6'} | rev | cut -c2- | rev | head -n1`
        echo "Mail IP is:" `dig $MX a +short`
        Who=`dig $MX +short`
        echo
        echo "The $domain MX record is pointing to: " `whois $Who 2>&1 | grep -i "OrgName" | cut -d ":" -f2`
echo
# TXT record fo the domain

                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  TXT record result of the $domain"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo
        dig +nocmd $domain txt +noall +answer
#PTR record of the domain
        IP=`dig +nocmd $domain a +noall +answer | grep ^"$domain" | grep A | awk {'print $5'} | head -n1`
                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  PTR record of the $IP"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo
        dig -x $IP +noall +answer | grep -vE ^";|^$"
echo
#WHOIS record of the domain

echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  Whois informaion of the $domain"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"

whois $domain | grep -E "Registrar:|Registry Expiry Date:|Registrar URL:|Name Server:|Expiration Date:|URL:"
echo
echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
else echo -e "\e[31m\e[1m Please enter a valid domain $domain \e[0m"
fi
```

### Used commands

- _dig_
- _whois_
