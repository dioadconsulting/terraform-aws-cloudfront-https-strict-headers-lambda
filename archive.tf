data "archive_file" "strict_headers" {
  type = "zip"
  #source_file = "${path.module}/lambda/strict_headers.js"
  source_content          = "${file("${path.module}/lambda/strict_headers.js")}"
  source_content_filename = "index.js"
  output_path             = "${path.module}/files/strict_headers.zip"
}