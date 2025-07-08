resource "null_resource" "copy_ec2_keys" {
  depends_on = [module.ec2_public]

  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    private_key = file("private-key/eks-terraform-key.pem")
  }

  provisioner "file" {
    source      = "private-key/eks-terraform-key.pem"
    destination = "/home/ec2-user/eks-terraform-key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/ec2-user/eks-terraform-key.pem /tmp/eks-terraform-key.pem",
      "sudo chmod 600 /tmp/eks-terraform-key.pem"
    ]
  }

  provisioner "local-exec" {
    command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
  }
}
