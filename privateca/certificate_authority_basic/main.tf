/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# [START privateca_create_ca]
resource "google_privateca_certificate_authority" "root_ca" {
  // This example assumes this pool already exists.
  // Pools cannot be deleted in normal test circumstances, so we depend on static pools
  pool                                   = "my-pool"
  certificate_authority_id               = "my-certificate-authority-root"
  location                               = "us-central1"
  deletion_protection                    = false # set to true to prevent destruction of the resource
  ignore_active_certificates_on_deletion = true
  config {
    subject_config {
      subject {
        organization = "ACME"
        common_name  = "my-certificate-authority"
      }
    }
    x509_config {
      ca_options {
        # is_ca *MUST* be true for certificate authorities
        is_ca = true
      }
      key_usage {
        base_key_usage {
          # cert_sign and crl_sign *MUST* be true for certificate authorities
          cert_sign = true
          crl_sign  = true
        }
        extended_key_usage {
        }
      }
    }
  }
  key_spec {
    algorithm = "RSA_PKCS1_4096_SHA256"
  }
  // valid for 10 years
  lifetime = "${10 * 365 * 24 * 3600}s"
}
# [END privateca_create_ca]
