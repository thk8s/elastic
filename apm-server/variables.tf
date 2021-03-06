variable "helm_install_timeout" {
    type = number
    default = 600
    description = "Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks)"
}
variable "es_version" {
    type = string
    description = "Elasticsearch version"
}

variable "namespace" {
    type = string
    description = "Namespace in which service will be deployed"
}

variable "name" {
    type = string
    default = "kibana"
}

variable "apm_config" {
    type = map(string)
    default = {
        "apm-server.yml" = <<EOT
apm-server:
  host: "0.0.0.0:8200"

queue: {}

output.elasticsearch:
  hosts: ["http://elasticsearch-master:9200"]
  ## If you have security enabled- you'll need to add the credentials
  ## as environment variables
  # username: "\${ELASTICSEARCH_USERNAME}"
  # password: "\${ELASTICSEARCH_PASSWORD}"
  ## If SSL is enabled
  # protocol: https
  # ssl.certificate_authorities:
  #  - /usr/share/apm-server/config/certs/elastic-ca.pem
EOT
    }
}

variable "replicas" {
    type = number
    default = 1
}

variable "extra_containers" {
    type = list(object({}))
    default = []
}

variable "extra_init_containers" {
    type = list(object({}))
    default = []
}

variable "extra_volumes" {
    type = list(object({}))
    default = []
}

variable "extra_volume_mounts" {
    type = list(object({}))
    default = []
}

variable "extra_envs" {
    type = object({
        name = string
        value = string
    })
    default = []
}

variable "env_form" {
    type = list(object({}))
    default = []
}


variable "image" {
    type = string
    default = "docker.elastic.co/apm/apm-server"
}

variable "image_tag" {
    type = string
    default = "7.8.1-SNAPSHOT"
}

variable "image_pull_policy" {
    type = string
    default = "IfNotPresent"
}

variable "image_pull_secrets" {
    type = list(object({}))
    default = []
}

variable "managed_service_account" {
    type = bool
    default = true
}


variable "labels" {
    type = object({})
    default = {}
}

variable "pod_annotations" {
    type = object({})
    default = {}
}

variable "pod_security_context" {
    type = object({})
    default = {}
}


variable "liveness_probe" {
    type = object({})
    default = {
        httpGet = {
            path = "/"
            port = "http"
        }
        initialDelaySeconds = 30
        periodSeconds = 10
        timeoutSeconds = 5
        failureThreshold = 3
        successThreshold = 1
    }
}

variable "readiness_probe" {
    type = object({})
    default = {
        httpGet = {
            path = "/"
            port = "http"
        }
        initialDelaySeconds = 30
        periodSeconds = 10
        timeoutSeconds = 5
        failureThreshold = 3
        successThreshold = 3
    }
}


variable "resources" {
    type = object({
        requests = object({
            cpu = string
            memory = string
        })
        limits = object({
            cpu = string
            memory = string
        })
    })

    default = {
        requests = {
            cpu = "100m"
            memory = "100Mi"
        }
        limits = {
            cpu = "1000m"
            memory = "512Mi"
        }
    }

    description = "Allows you to set the resources for the statefulset"
}

variable "service_account" {
    type = string
    default = ""
}

variable "service_account_annotations" {
    type = object({})
    default = {}
}

variable "secret_mounts" {
    type = list(object({}))
    default = []
}

variable "termination_grace_period" {
    type = number
    default = 30
}

variable "tolerations" {
    type = list(object({}))
    default = []
}

variable "node_selector" {
    type = object({})
    default = {}
}

variable "affinity" {
    type = object({})
    default = {}
}

variable "priority_class_name" {
    type = string
    default = ""
}

variable "update_strategy" {
    type = object({})
    default = {
        type: "Recreate"
    }
}

variable "name_override" {
    type = string
    default = ""
}

variable "full_name_override" {
    type = string
    default = ""
}

variable "autoscaling" {
    type = object({})
    default = {
        enabled = false
    }
}

variable "ingress" {
    type = object({})
    default = {
        enabled = false
        annotations = {}
        path = "/"
        hosts = [
            "chart-example.local"
        ]
        tls: []
    }
}

variable "service" {
    type = object({})
    default = {
        type = ClusterIP
        port = 8200
        nodePort = ""
        annotations = {}
    }
}

variable "lifecycle" {
    type = object({})
    default = {}
}