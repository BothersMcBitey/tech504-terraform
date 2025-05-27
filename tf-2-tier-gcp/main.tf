provider "google" {
  project = var.project_id
  region  = var.region
}

#should be a "google_compute_network"

resource "google_compute_network" "tech504-callum-tf-vpc" {
  project = var.project_id
  name = "tech504-callum-tf-vpc"
  description = "vpc made by terraform for a 2-tier deployment"

  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "tech504-callum-public-subnet" {
  name  = "public-subnet"
  ip_cidr_range = "10.0.2.0/24" 
  region = var.region
  network = google_compute_network.tech504-callum-tf-vpc.id

  stack_type = "IPV4_ONLY"  
}

resource "google_compute_subnetwork" "tech504-callum-private-subnet" {
  name  = "private-subnet"
  ip_cidr_range = "10.0.3.0/24" 
  region = var.region
  network = google_compute_network.tech504-callum-tf-vpc.id

  stack_type = "IPV4_ONLY"  
}

resource "google_compute_firewall" "tech504-callum-firewall-app" {
  name = "callum-firewall-app"
  network = google_compute_network.tech504-callum-tf-vpc.id
  
  allow {
    protocol = "tcp"
    ports = ["22", "80", "3000"]
  }

  source_tags = ["http-server"]
}

resource "google_compute_firewall" "tech504-callum-firewall-db" {
  name = "callum-firewall-db"
  network = google_compute_network.tech504-callum-tf-vpc.id
  
  allow {
    protocol = "tcp"
    ports = ["22", "27017"]
  }

  source_tags = ["http-server"]
  target_tags = ["db-server"]
}

resource "google_compute_instance" "tech504-callum-sparta-app-vm-tf" {
  boot_disk {
    auto_delete = true
    device_name = "tech504-callum-sparta-app-template"

    initialize_params {
      image = "projects/sparta-academy-455414/global/images/tech504-callum-sparta-app-image"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  machine_type = "e2-small"

  metadata = {
    enable-osconfig = "TRUE"
    startup-script  = "#!/bin/bash\ncd sparta_test_app-main/app/\npm2 start app.js --name sparta_app"
  }

  name = "tech504-callum-sparta-app-from-tf"

  network_interface {
    access_config {
      network_tier = "STANDARD"
    }
    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = google_compute_subnetwork.tech504-callum-public-subnet.id
  }

  tags = ["http-server"]
  zone = var.zone
}
 
 resource "google_compute_instance" "tech504-callum-mongodb-vm-tf" {
  boot_disk {
    auto_delete = true
    device_name = "mongodb-vm-template"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20250425"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  machine_type = "e2-small"

  name = "tech504-callum-mongodb-vm-tf"

  network_interface {


    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = google_compute_subnetwork.tech504-callum-private-subnet.id
  }

  tags = ["db-server"]
  zone = var.zone
}