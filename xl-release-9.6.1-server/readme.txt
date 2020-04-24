INSTALL XL RELEASE

-------------------
Server requirements
-------------------

The XL Release server requires:

* Microsoft Windows or Unix-family operating system
* Java Development Kit (JDK) 1.8 (Oracle or IBM)
* At least 2 GB of RAM available for XL Release
* At least 2 GB of hard disk space available to store the XL Release repository (the exact amount of space required depends on your usage of XL Release)

Depending on the environment, the following may also be required:

* Database: XL Release repository may be stored in a database
* LDAP: To enable group-based security, an LDAP x.509 compliant registry is required

-------------------
Client requirements
-------------------

The XL Release user interface requires one of the following browsers:

* Internet Explorer 11.0 or later
* Firefox
* Chrome

----------------------
Installation procedure
----------------------

To install XL Release:

1. Download the XL Release ZIP file from https://dist.xebialabs.com.
2. Extract the ZIP file to the directory where you want to install XL Release; for example, /opt/xebialabs/xl-release or C:\Program Files\XL Release. This is referred to as <XLRELEASE_HOME>.
3. Copy your license file to <XLRELEASE_HOME>/conf/xl-release-license.lic.
4. Open a command prompt and navigate to <XLRELEASE_HOME>/bin.
5. Execute one of the following commands to start the setup wizard:
   * On Unix: run.sh -setup
   * On Windows: run.cmd -setup
6. After installation is complete, you will see the message "Finished setup".

By default, the XL Release user interface is available at http://localhost:5516. The default username is admin and default password is admin.

To install or uninstall XL Release as a service:
(These scripts require the current user to be root on Linux or an Administrator on Windows.)

* Run install-service.sh or install-service.cmd script.
* Run uninstall-service.sh or uninstall-service.cmd script.

-------------
Documentation
-------------

For more information about XL Release, visit https://docs.xebialabs.com.
