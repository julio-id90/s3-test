resource "local_file" "file1" {
    content         = timestamp()
    file_permission = "0644"
    filename        = "test1.txt"
}

resource "local_file" "file2" {
    content         = timestamp()
    file_permission = "0644"
    filename        = "test2.txt"
}

resource "local_file" "ssh_private_key" {
    content         = tls_private_key.traefik_tls.private_key_pem
    file_permission = "0400"
    filename        = "id_rsa_traefik"
}
