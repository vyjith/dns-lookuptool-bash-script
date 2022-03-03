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

        whois $domain_name 2>&1 | grep -E "Registrar:|Registry Expiry Date:|Registrar URL:|Name Server:|Expiration Date:|URL:"
echo
echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"

echo ""
echo ""
echo -e "\e[31m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
        echo " Here we are just comparing the nameserver info in the DNS zone and Whois"
                echo -e "\e[31m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo ""
                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  Nameserver details $domain_name in DNS zone"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo ""
NS=`dig $domain_name ns +short | sort`
IP=`dig $NS a +short`
for p in $NS; do echo "   NameServer : " $p; done
echo ""
for i in $IP; do echo -e "   The $i is Pointing to :" `whois $i 2>&1 | grep -i "OrgName" | cut -d ":" -f2`; done
echo ""
                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
                        echo "  Nameserver details $domain_name in whois"
                                echo  -e "\e[32m\e[1m ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0m"
echo ""
whois $domain_name 2>&1 | grep -E "Name Server:"
IPS=`whois $domain_name 2>&1 | grep -E "Name Server:" | awk {'print $3'} | sort`
echo ""
for j in $(dig $IPS a +short); do echo -e "   The $j is Pointing to :" `whois $j 2>&1 | grep -i "OrgName" | cut -d ":" -f2`; done
echo ""

        else
                echo -e "\e[31m\e[1mPlease enter a FQDN domain like ('Google.com). Also, don't use protocol (http://,https://) and symbol's\e[0m"
        fi
else
        echo -e "\e[31m\e[1mOops!! You didn't give any input. Please give the domain name. \e[0m"
fi

