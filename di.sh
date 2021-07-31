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
