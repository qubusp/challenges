variable "project_name" {
    default = "devops_test"
}
variable "billing_account" {
    default = "RichyRich"
}
variable "org_id" {
    default = "random_id"
}
variable "region" {
    default = "eu-west-4"
}

provider "google" {
  region = var.region
}

resource "random_id" "id" {
  byte_length = 4
  prefix      = var.project_name
}

resource "google_project" "project" {
  name            = var.project_name
  project_id      = random_id.id.hex
  billing_account = var.billing_account
  org_id          = var.org_id
}

resource "google_project_service" "service" {
  for_each = toset([
    "compute.googleapis.com"
  ])

  service = each.key

  project            = google_project.project.project_id
  disable_on_destroy = false
}

output "project_id" {
  value = google_project.project.project_id
}

data "google_compute_zones" "available" {
  project = google_project.project.project_id
}

resource "google_compute_instance" "default" {
  project      = google_project.project.project_id
  zone         = data.google_compute_zones.available.names[0]
  name         = "tf-compute-1-${count.index}"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20170328"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  depends_on = [google_project_service.service]
}

output "instance_id" {
  value = google_compute_instance.default.self_link
}

module module "load-balancer_http-load-balancer" {
  source  = "gruntwork-io/load-balancer/google//modules/http-load-balancer"
  version = "0.2.0"
  project = google_project.project.id
  name    = "${var.project_name}-LB-HTTP"
  url     = google_compute_instance.default.self_link
}