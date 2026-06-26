# Architecture - AWS NFS File Sharing System

## Overview
This project uses one NFS server and multiple Linux clients on AWS EC2 to enable centralized file sharing.

## Architecture Diagram

                AWS VPC
                   │
        ┌──────────┴──────────┐
        │                     │
   NFS SERVER            CLIENT 1
 (172.31.x.x)          (mounts share)
        │                     │
        │                CLIENT 2
        │             (mounts share)
        │
   /shared/data (exported folder)

## Components

### NFS Server
- Hosts shared directory
- Exports `/shared/data`

### Clients
- Mount shared directory at `/mnt/shared`
- Access shared files in real-time

## Network
- All instances in same VPC
- NFS ports enabled (2049, 111)
