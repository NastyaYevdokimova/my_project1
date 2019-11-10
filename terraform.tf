provider "google" {
  credentials = "${file("cread.json")}"
  project     = "prod-254416"
  region      = "us-central1"
}

resource "google_compute_instance" "webserver" {
  name         = "apache-server4"
  machine_type = "g1-small"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }
  metadata_startup_script = "sudo apt -y update; sudo apt install apache2 -y; sudo chmod 777 /var/www/html; echo <h1>Simple DevOps project</h1> > /var/www/html/index.html; sudo service apache2 restart;"
  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_firewall" "default" {
  name    = "apache-firewall4"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  allow {
    protocol = "icmp"
  }
}
