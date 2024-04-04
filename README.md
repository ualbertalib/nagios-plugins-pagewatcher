# README for nagios-plugins-pagewatcher

This is a Nagios plugin designed to alert when the contents of a web page changes.

## Why? 

* We need to be aware of a web page that IST has committed to changing once a week - a list of upcoming planned changes.
* Noticing when Netdata's posted an updated release on their GH page
* (probably a bunch of other software projects) 

##  Inputs: 

* This takes 2 inputs
    * a one-word unique description of the web page you need to watch
    * the URL for the web page

## For Example 

```
[nmacgreg@its004nm2 PageWatcher]$ ./check_webpage.sh "IST_Changes" "https://www.ualberta.ca/information-services-and-technology/upcoming-changes/index.html"
Initial checksum populated for IST_Changes
```

* Subsequently: 

```
[nmacgreg@its004nm2 PageWatcher]$ ./check_webpage.sh "IST_Changes" "https://www.ualberta.ca/information-services-and-technology/upcoming-changes/index.html"
OK: IST_Changes webpage content unchanged
```

