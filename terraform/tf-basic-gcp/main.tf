provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "tech504-callum-tf-test" {
  name         = "tech504-callum-tf-test"
  machine_type = var.machine_type
  zone = var.zone

  boot_disk {
    auto_delete = true
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2204-jammy-v20250521"
      size  = 10
      type  = "pd-balanced"
    }
  }

  network_interface {
    access_config {
      network_tier = "STANDARD"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/sparta-academy-455414/regions/europe-southwest1/subnetworks/default"
  }

  tags = ["http-server"]
}
