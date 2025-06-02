+++
date = 2024-03-19T06:25:08+02:00
title = "How to Stream Headless Kali Linux to Your Browser"
slug = "how-to-stream-headless-kali-linux-to-your-browser"
tags = ["Headless Setup", "TigerVNC", "noVNC", "Old Gaming PC", "Remote Desktop", "Tech Recycling", "Linux Setup", "Cybersecurity Tools"]
categories = ["Kali Linux", "Cybersecurity", "Tech DIY", "Remote Access"]
+++

{{< figure src="https://cdn.loncar.net/how-to-stream-headless-kali-linux-to-your-browser.png" alt="How to Stream Headless Kali Linux to Your Browser" >}}

## 🔄 TL;DR

* Installed Kali Linux on an old gaming PC with a graphical installation and XFCE desktop environment
* Transformed it into a headless setup for more flexibility and remote-friendly interaction
* Used TigerVNC and noVNC to bridge the gap between headless hardware and the need for a graphical interface
* Result: Kali Linux runs unencumbered by physical peripherals, and its graphical interface streams flawlessly to a web browser, offering both the power of Kali Linux and the flexibility of remote access.

## The Journey to a Headless Kali Linux

Discovering an old gaming PC tucked away in the cellar felt like unearthing a hidden treasure. With a penchant for Debian-based distributions and a keen interest in cybersecurity, I decided to breathe new life into this forgotten relic by installing [Kali Linux](https://www.kali.org/). Opting for a graphical installation, I chose the lightweight, efficient [Xfce Desktop Environment](https://xfce.org/), perfect for my needs.

However, my enthusiasm for a sleek, minimal setup led me to an unconventional decision: I disconnected the monitor, keyboard, and mouse, embracing a headless setup. This transformation wasn't just about reclaiming physical space; it was about setting the stage for a more
flexible, remote-friendly interaction with Kali Linux.

To bridge the gap between the headless hardware and my need for a graphical interface, I turned to [TigerVNC](https://tigervnc.org/), [noVNC](https://novnc.com/) and [websockify](https://github.com/novnc/websockify), powerful tools that seamlessly bridge my Kali Linux box to my web browser. This setup allows me to run Kali Linux without physical peripherals, controlling it entirely through my browser.

## The Setup Process

### Step 1: Choosing XFCE

The first step was installing the XFCE desktop environment during the Kali Linux setup. XFCE is known for its simplicity and low resource usage, making it an ideal choice for a system being repurposed as a headless server.

If you're not utilising graphical installation, you can install XFCE using the following command:

```bash
sudo apt update
sudo apt install kali-linux-default kali-desktop-xfce
```
### Step 2: Disabling LightDM and Clearing Locked Files in /tmp

To ensure that unnecessary services don't consume system resources or conflict with our headless setup, start by disabling and stopping LightDM

```bash
sudo systemctl disable lightdm.service
sudo systemctl stop lightdm.service
```

Next, address potential issues with locked files in the `/tmp` directory. Locked or stale files in `/tmp` can sometimes cause problems, especially after changing how the system handles graphical sessions. Safely remove these locked files to avoid any session conflicts:

```bash
sudo rm /tmp/.X*-lock
sudo rm /tmp/.X11-unix/X*
```

> It's crucial to ensure that these actions don't inadvertently affect any currently running processes. The commands target specific lock files related to X sessions, which should be safe to remove if you're transitioning to a purely VNC-based setup.

### Step 3: Introducing TigerVNC and noVNC

Set up TigerVNC to provide remote access to the XFCE desktop environment and implement noVNC to access the VNC session via a web browser, facilitating a seamless interface to interact with Kali Linux remotely. This step involves installing TigerVNC and noVNC with the following command:

```bash
sudo apt install tigervnc-standalone-server novnc
```

## Setup the environment

Once finished with the installation, we need to set up the VNC password. No need to set a view-only password.

```bash
┌──(infosec㉿ShadowFox)-[~]
└─$ vncpasswd
Password:
Verify:
Would you like to enter a view-only password (y/n)? n
A view-only password is not used
```

We also need to create a file needed for VNC. It does not need to have anything in it.

```bash
┌──(infosec㉿ShadowFox)-[~]
└─$ touch ~/.Xresources
```

## Start / Stop the Services

I've created a few bash scripts to start and stop the services.

### stop-novnc.sh

```bash
#!/usr/bin/env bash

# Find the PID of the websockify process
pid=$(pgrep -f 'websockify')

# Check if websockify process was found
if [ -z "$pid" ]; then
  echo "websockify process not found. It may not be running."
else
  # Kill the websockify process using its PID
  kill $pid
  echo "websockify process (PID: $pid) has been stopped."
fi
```

### start-novnc.sh

```bash
#!/usr/bin/env bash

# Default VNC port
default_vnc_port="5900"

# # Use provided port or default
vnc_port=${1:-$default_vnc_port}

# Run the websockify command to start noVNC
websockify -D --web /usr/share/novnc/ 8081 localhost:$vnc_port
```

### stop-vnc.sh

```bash
#!/usr/bin/env bash

# Default display
default_display=":0"

# Use provided display or default
display=${1:-$default_display}

# Kill the TigerVNC server on the specified display
tigervncserver -kill $display
```

### start-vnc.sh

```bash
#!/usr/bin/env bash

# Default values for geometry and depth
default_geometry="1920x1080"
default_depth="32"

# Use provided values or defaults
geometry=${1:-$default_geometry}
depth=${2:-$default_depth}

# Run the tigervncserver command with the specified or default parameters
tigervncserver -xstartup /usr/bin/xfce4-session -localhost -depth $depth -geometry $geometry -display :0
```

## Why Not x11vnc?

> [Kali In The Browser (noVNC)](https://www.kali.org/docs/general-use/novnc-kali-in-browser/)

An important decision in this journey was opting not to use x11vnc. The key reason is that x11vnc shares an existing X session rather than creating a new virtual desktop environment. In a headless setup, where there's no physical display connected, a virtual desktop is crucial.

TigerVNC provides:

* This capability.
* Creating a virtual desktop session that can be accessed remotely.
* Making it the superior choice for this particular setup.

## The End Result

Now, my Kali Linux system runs unencumbered by physical peripherals, and its graphical interface streamed flawlessly to my browser (or even to VNC client). This setup capitalizes on the capabilities of an old gaming PC. It aligns perfectly with my cybersecurity projects, offering both the power of Kali Linux and the flexibility of remote access.

## Small Demonstration

{{< youtube wq25LEkXAhw >}}
