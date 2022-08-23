# PS_Domain_Scanner
This Powershell script aims to scan domains from text (.txt) file.
It gives output about domains' IP address, HTTP Response, Status Code, Headers and Lenght of response.

## Purpose
I have created this script to monitor and check diffrent domains hosted by an organization based upon minimal possible scripting resource available i.e. PowerShell.

## Usage
Search and update following rows with source and destinition files respectively (full or relative OS path). **Do not remove quoation marks (").**
```
$src = "<Path to file>\domainlist.txt"
$dst = "<Path to file>\domains.csv"
```
Enjoy!!
