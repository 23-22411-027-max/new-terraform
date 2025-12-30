## Architecture Overview

The infrastructure uses a classic multi-tier architecture deployed on AWS, managed entirely by Terraform.

**Key Components:**
1.  **Networking:** A single VPC with a public subnet in an Availability Zone.
2.  **Load Balancer/Proxy (Tier 1):** A single Nginx server handling SSL termination, load balancing, and caching.
3.  **Backend Web Servers (Tier 2):** Three Apache servers running the web application.


### Flow of Traffic:
1.  Client connects via **HTTPS** (Port 443) to the Nginx server's public IP.
2.  All **HTTP** traffic (Port 80) is permanently redirected to HTTPS (301 redirect).
3.  Nginx acts as a reverse proxy, load balancing traffic using the default **Round Robin** method between **Web-1** and **Web-2**.
4.  **Web-3** is designated as a **backup server** and only receives traffic if both Web-1 and Web-2 fail (demonstrating high availability).
5.  Nginx caches responses from the backend servers for 10 minutes (or 60 minutes, depending on the final config i used) to improve performance.
## Architecture Diagram

┌─────────────────────────────────────────────────┐
│                  Internet                       │
└─────────────────┬───────────────────────────────┘
                  │ HTTPS (443)
                  │ HTTP (80) -> 301 Redirect
                  ▼
         ┌────────────────────┐
         │   Nginx Server     │
         │  (Load Balancer)   │
         │   (Tier 1)         │
         └────────┬───────────┘
                  │ HTTP (80)
      ┌───────────┼───────────┐
      │           │           │
      ▼           ▼           ▼
   ┌─────┐     ┌─────┐     ┌─────┐
   │Web-1│     │Web-2│     │Web-3│
   │ (P) │     │ (P) │     │(BKP)│
   └─────┘     └─────┘     └─────┘
   Primary     Primary     Backup
   (Tier 2)    (Tier 2)    (Tier 2)