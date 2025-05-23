provider "google" {
  project = var.project_id
  region  = var.region
}

#should be a "google_compute_network"

resource "google_vmwareengine_private_cloud" "tech504-callum-tf-vpc" {
  location = var.zone
  name = "tech504-callum-tf-vpc"
  description = "vpc made by terraform for a 2-tier deployment"

  network_config {
    management_cidr = "192.168.30.0/24"
    vmware_engine_network = google_vmwareengine_network.tech504-callum-pc-idu.id
  }

  management_cluster {
    cluster_id = "tech504-callum-mgmt-cluster"
    node_type_configs {
      node_type_id = "standard-72"
      node_count   = 3
    }
  }
}

resource "google_vmwareengine_network" "tech504-callum-pc-idu" {
  name        = "tech504-callum-pc-idu"
  location    =  var.region
  type        = "STANDARD"
  description = "PC network description."
}