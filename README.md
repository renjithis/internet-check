# internet-check
Bash script to check internet connection 
Uses zenity for alert messages
Uses ping to check internet connection

# Usage
```
$ chmod +x internet-check.sh
```
```
$ ./internet-check.sh [-d] [-c] [-i] [-p PING_ADDRESS]
```
  -d  Alert if internet disconnects and exit
  -c  Alert if internet connects and exit
  -i  Do not exit after connect/disconnect. If connected, continue check for disconnect and vise versa.
      To be used for continuous background operation
     
# Usage as a startup application

- Open your startup appliction editor and select add command
- Browse to internet-check.sh
- Add argumets -d -i 
- Redirect all output to /dev/null

As shown below :
>  /[path to internet-check.sh]/**internet-check.sh -d -i &>/dev/null**
