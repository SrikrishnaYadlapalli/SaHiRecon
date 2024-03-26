#!/bin/bash

# Colors
RESET="\e[0m"
GRAY="\e[1;30m"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
PURPLE="\e[1;35m"
CYAN="\e[1;36m"
WHITE="\e[1;37m"

banner () {
    clear
    echo -e "${YELLOW}                                                ${RESET}"
    echo -e "${YELLOW} / ___|  __ _| | | (_)  _ \ ___  ___ ___  _ __   ${RESET}"
    echo -e "${YELLOW} \___ \ / _  | |_| | | |_) / _ \/ __/ _ \|  _ \  ${RESET}"
    echo -e "${YELLOW}  ___) | (_| |  _  | |  _ <  __/ (_| (_) | | | | ${RESET}"
    echo -e "${YELLOW} |____/ \__,_|_| |_|_|_| \_\___|\___\___/|_| |_| ${RESET}"
    echo -e "${RED}               Created by: Srikrishna Yadlapalli${RESET}"
}

divider () {
    echo 
    echo -e "${BLUE}=============================================================${RESET}"
    echo
}

help () {
    clear
    banner
    echo
    echo -e "USAGE:$0 [DOMAIN] [OPTIONS...]"
    echo -e "\t-h , --help   Help Menu"
    echo -e "\t-hx, --httpx  Get live domains"
    echo -e "\t-u,  --urls   Get all urls"
    echo -e "\t-p,  --parameter Get parameters"
    echo -e "\t-w,  --wayback Get wayback data"
    echo -e "\t--whois,  Get who is data"
    echo -e "\t-ps,    Get portscan data" 
    echo -e "\t-c,  --cors  Get possible CORS misconfigurations"
    echo
}

DOMAIN=$1

if [ $# -eq 0 ]; then 
    help
    exit 1
fi

# Check for existing directory, create if it doesn't exist
if [ ! -d "$DOMAIN" ]; then 
    mkdir "$DOMAIN"
    cd "$DOMAIN" || exit 1
fi

banner
divider
echo -e "${CYAN}[-] Gathering Sub-Domains...${RESET}"

# Gather subdomains
subfinder -silent -d "$DOMAIN" > subdomains_subfinder.txt
assetfinder "$DOMAIN" > subdomains_assetfinder.txt
cat subdomains_*.txt | sort -u > subdomains_combined.txt
rm subdomains_subfinder.txt subdomains_assetfinder.txt

echo -e "${CYAN}[+] Sub-Domain gathering completed.${RESET}"
divider

# Process options
while [[ $# -gt 1 ]]; do
    case "$2" in
        "-h" | "--help" )
            help
            exit 4
            ;;
        "-hx" | "--httpx" )
            echo -e "${CYAN}[-] Running httpx...${RESET}"
            cat subdomains_combined.txt | httpx | tee live-domain.txt
            echo -e "${CYAN}[+] Live Sub-domains gathered.${RESET}"
            divider
            ;;
        "-u" | "--url" )
            echo -e "${CYAN}[-] Gathering URLs...${RESET}"
            gau "$DOMAIN" | tee urls.txt
            echo -e "${CYAN}[+] URLs Gathered.${RESET}"
            divider
            ;;
        "-p" | "--parameter" )
            echo -e "${CYAN}[-] Gathering parameters for the domain...${RESET}"
            paramspider -d "$DOMAIN"
            echo -e "${CYAN}[+] Parameters gathered and stored.${RESET}"
            divider
            ;;
        "-w" | "--wayback" )
            echo -e "${CYAN}[-] Gathering wayback data...${RESET}"
            waybackurls "$DOMAIN" | tee waybackurls.txt
            echo -e "${CYAN}[+] Wayback data gathered.${RESET}"
            divider
            ;;
        "--whois" )
            echo -e "${CYAN}[-] Gathering data from whois.com...${RESET}"
            curl -s "https://www.whois.com/whois/$DOMAIN" | grep -A 70 "Registry Domain ID:" | tee whois.txt
            echo -e "${CYAN}[+] Whois Data gathered.${RESET}"
            divider
            ;;
        "-ps" | "--portscan" )
            echo -e "${CYAN}[-] Doing portscan using naabu...${RESET}"
            naabu -l subdomains_combined.txt -o naabu.txt
            echo -e "${CYAN}[+] Portscan done.${RESET}"
            divider
            ;;
         
         "-c" | "--CORS" )
            echo -e "${CYAN}[-] Checking for CORS misconfiguration...${RESET}"
            katana -u https://www.$DOMAIN/ -o katana.txt
            python3 /home/sahi/BBH/test/Corsy/corsy.py -i katana.txt -o corsy.txt
            echo -e "${CYAN}[-] Possible CORS misconfiguration checked...${RESET}"
            divider
            ;;
            
        * )
            echo "Invalid option: $2"
            help
            exit 1
            ;;
    esac
    shift
done

divider 
echo -e "${CYAN}Recon finished and results are saved.${RESET}"
divider
