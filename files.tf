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
