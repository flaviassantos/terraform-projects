terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.29.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

variable "digitalocean_token" {
  description = "token generated to access the DigitalOcean API"
}

variable "ssh_key" {
  description = "public ssh key"
}

variable my_ip {}

data "digitalocean_ssh_key" "default" {
  name = "my-droplet-key"
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-22-04-x64"
  name   = "jenkins-server"
  region = "fra1"
  size   = "s-2vcpu-4gb"
  ssh_keys = [data.digitalocean_ssh_key.default.fingerprint]
}

output "ipv4-droplet" {
  value = digitalocean_droplet.web.ipv4_address
}

resource "digitalocean_firewall" "web" {
  name = "only-22-and-8080"

  droplet_ids = [digitalocean_droplet.web.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [var.my_ip]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080" # where jenkins starts
    source_addresses = ["0.0.0.0/0", "::/0"] # CIDR
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}


