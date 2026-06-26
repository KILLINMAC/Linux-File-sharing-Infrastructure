# 🖥️ Linux NFS File Sharing Infrastructure

A Bash-based automated infrastructure project that sets up **NFS (Network File System)** file sharing between one Linux server and multiple Linux clients on **AWS EC2**.

---

## 📌 What is This Project?

This project automates the setup of a shared folder between Linux machines using NFS.  
One machine acts as the **server** (shares the folder) and the other machines act as **clients** (access the shared folder).

Think of it like a shared Google Drive — but on Linux servers.

---

## ✨ Features

- ✅ Automated NFS server setup
- ✅ Automated NFS client setup (supports multiple clients)
- ✅ Shared folder accessible by all clients
- ✅ Persistent mount (survives server reboot)
- ✅ Simple Bash scripts — easy to understand and run

---

## 🏗️ Architecture

```
              AWS VPC
  ┌─────────────────────────────────┐
  │                                 │
  │     ┌──────────────────┐        │
  │     │   NFS SERVER     │        │
  │     │   EC2 Instance   │        │
  │     │  /srv/nfs/share  │        │
  │     └────────┬─────────┘        │
  │              │  shares folder   │
  │       ───────┼───────           │
  │      │       │       │          │
  │      ▼       ▼       ▼          │
  │   Client1  Client2  Client3     │
  │   EC2       EC2      EC2        │
  │  /mnt/nfs /mnt/nfs /mnt/nfs    │
  │                                 │
  └─────────────────────────────────┘
```

---

## 📁 Project Structure

```
Linux-File-sharing-Infrastructure/
├── server/
│   └── setup_nfs_server.sh       ← Run this on the NFS Server EC2
├── client/
│   └── setup_nfs_client.sh       ← Run this on each Client EC2
├── docs/
│   └── setup-guide.md            ← Detailed setup documentation
├── Screenshots/
│   └── *.png                     ← Project screenshots
└── README.md
```

---

## ⚙️ Prerequisites

### AWS Setup
- 1 EC2 instance for the **NFS Server**
- 1 or more EC2 instances for **NFS Clients**
- All instances in the **same VPC and Subnet**
- AMI: Amazon Linux 2 or Ubuntu 22.04

### Security Group — Inbound Rules

| Type | Protocol | Port | Source |
|---|---|---|---|
| SSH | TCP | 22 | Your IP |
| Custom TCP | TCP | 2049 | Your VPC CIDR |
| Custom UDP | UDP | 2049 | Your VPC CIDR |
| Custom TCP | TCP | 111 | Your VPC CIDR |
| Custom UDP | UDP | 111 | Your VPC CIDR |

> 💡 Use your VPC CIDR (e.g. `172.31.0.0/16`) as source — not `0.0.0.0/0`

---

## 🚀 How to Use

### Step 1 — Clone the Repository

```bash
git clone https://github.com/KILLINMAC/Linux-File-sharing-Infrastructure.git
cd Linux-File-sharing-Infrastructure
```

### Step 2 — Set Up the NFS Server

SSH into your **Server EC2**:

```bash
ssh -i your-key.pem ec2-user@SERVER-PUBLIC-IP
```

Run the server script:

```bash
chmod +x server/setup_nfs_server.sh
sudo bash server/setup_nfs_server.sh
```

### Step 3 — Set Up Each NFS Client

SSH into each **Client EC2**:

```bash
ssh -i your-key.pem ec2-user@CLIENT-PUBLIC-IP
```

Open the client script and set the server IP:

```bash
nano client/setup_nfs_client.sh
# Change SERVER_IP="172.31.x.x" to your actual NFS Server Private IP
```

Run the client script:

```bash
chmod +x client/setup_nfs_client.sh
sudo bash client/setup_nfs_client.sh
```

### Step 4 — Test It Works

On any client, create a test file:

```bash
echo "Hello from Client 1" > /mnt/nfs/test.txt
```

On another client, check if you can see it:

```bash
cat /mnt/nfs/test.txt
# Output: Hello from Client 1
```

If you can see the file — NFS is working! 🎉

---

## 📄 Sample Output

### Server Setup
```
==========================================
   NFS SERVER SETUP
==========================================
Step 1 : Installing NFS Server...
  ✅ NFS Server installed.

Step 2 : Creating shared folder...
  ✅ Shared folder created at /srv/nfs/share

Step 3 : Configuring /etc/exports...
  ✅ Exports configured.

Step 4 : Starting NFS service...
  ✅ NFS service started and enabled.

==========================================
  ✅ NFS SERVER SETUP COMPLETE!
==========================================
```

### Client Setup
```
==========================================
   NFS CLIENT SETUP
==========================================
Step 1 : Installing NFS Client...
  ✅ NFS Client installed.

Step 2 : Creating mount point...
  ✅ Mount point created at /mnt/nfs

Step 3 : Mounting NFS share...
  ✅ NFS share mounted at /mnt/nfs

Step 4 : Making mount permanent...
  ✅ Mount added to /etc/fstab

==========================================
  ✅ NFS CLIENT SETUP COMPLETE!
==========================================
```

---

## 🔐 Security Notes

- NFS access is restricted to your **VPC CIDR only**
- Port 2049 (NFS) is not exposed to the public internet
- All EC2 instances must be in the **same Security Group**

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| **Bash** | Automation scripts |
| **NFS** | Network File System protocol |
| **Linux** | Operating system (Amazon Linux 2 / Ubuntu) |
| **AWS EC2** | Cloud instances (server + clients) |
| **AWS VPC** | Private network for secure communication |

---

## 🧠 Key Terms

| Term | Meaning |
|---|---|
| `NFS` | Network File System — share folders over a network |
| `/etc/exports` | Config file that tells NFS what to share |
| `exportfs -a` | Applies the export settings |
| `mount -t nfs` | Mounts the remote folder locally |
| `/etc/fstab` | Makes the mount automatic on reboot |
| `VPC CIDR` | IP range of your AWS private network |

---

## 👤 Author

**KILLINMAC**
GitHub: [@KILLINMAC](https://github.com/KILLINMAC)

---
