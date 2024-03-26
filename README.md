# SaHiRecon
![image](https://github.com/SrikrishnaYadlapalli/SaHIRecon/assets/51364472/27dbb7b9-7cb8-4b8b-ac1d-35b18901b1f0)

A Bash script designed to aid bug bounty beginners like me in reconnaissance by automating subdomain discovery, live domain identification, URL enumeration, and more. Organized into separate folders for easier understanding.

# Overview

This repository contains a Bash script for automating reconnaissance tasks in bug bounty hunting. It gathers information such as subdomains, live domains, URLs, parameters, Wayback Machine data, Whois data, port scanning, and CORS misconfigurations, providing beginners with the necessary information about the target domain to start bug hunting.

# Features

1.Sub-domain gathering using subfinder and assetfinder

2.Live sub-domain identification with httpx

3.URL enumeration using gau

4.Parameter discovery with paramspider

5.Wayback Machine data retrieval using waybackurls

6.Whois data extraction

7.Port scanning with naabu

8.CORS misconfiguration checking using katana and corsy.py




# Prerequisites

Ensure the following tools are installed and properly configured:

1.subfinder

2.assetfinder

3.httpx

4.gau

5.paramspider

6.waybackurls

7.naabu

8.katana

9.corsy.py


# Installation

Clone the repository:

``` git clone https://github.com/SrikrishnaYadlapalli/SaHIRecon.git ```

Change directory into SaHiRecon

``` cd SaHIRecon/ ```

Give permissions to the script

``` chmod +x SaHiRecon.sh ```

Run it

``` ./SaHiRecon.sh [DOMAIN] [OPTIONS...] ```

or just run the file to get usage options

``` ./SaHiRecon.sh ```

![image](https://github.com/SrikrishnaYadlapalli/SaHIRecon/assets/51364472/568214bd-e3bb-4dbf-a9c7-82fbd772139a)







