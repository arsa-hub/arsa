Sample init scripts and service configuration for arsad
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/arsad.service:    systemd service unit configuration
    contrib/init/arsad.openrc:     OpenRC compatible SysV style init script
    contrib/init/arsad.openrcconf: OpenRC conf.d file
    contrib/init/arsad.conf:       Upstart service configuration file
    contrib/init/arsad.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "arsacore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes arsad will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, arsad requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, arsad will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that arsad and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If arsad is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running arsad without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/arsa.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/arsad`  
Configuration file:  `/etc/arsacore/arsa.conf`  
Data directory:      `/var/lib/arsad`  
PID file:            `/var/run/arsad/arsad.pid` (OpenRC and Upstart) or `/var/lib/arsad/arsad.pid` (systemd)  
Lock file:           `/var/lock/subsys/arsad` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the arsacore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
arsacore user and group.  Access to arsa-cli and other arsad rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/arsad`  
Configuration file:  `~/Library/Application Support/ArsaCore/arsa.conf`  
Data directory:      `~/Library/Application Support/ArsaCore`
Lock file:           `~/Library/Application Support/ArsaCore/.lock`

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start arsad` and to enable for system startup run
`systemctl enable arsad`

### OpenRC

Rename arsad.openrc to arsad and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/arsad start` and configure it to run on startup with
`rc-update add arsad`

### Upstart (for Debian/Ubuntu based distributions)

Drop arsad.conf in /etc/init.  Test by running `service arsad start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy arsad.init to /etc/init.d/arsad. Test by running `service arsad start`.

Using this script, you can adjust the path and flags to the arsad program by
setting the ARSAD and FLAGS environment variables in the file
/etc/sysconfig/arsad. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.arsa.arsad.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.arsa.arsad.plist`.

This Launch Agent will cause arsad to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run arsad as the current user.
You will need to modify org.arsa.arsad.plist if you intend to use it as a
Launch Daemon with a dedicated arsacore user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
