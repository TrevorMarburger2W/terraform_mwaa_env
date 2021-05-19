output "vpc_id" {
    value = aws_vpc.mwaa_default_vpc.id
}

output "sec_group" {
    value = aws_security_group.main_sg.id
}

output "priv_subnet_1" {
    value = aws_subnet.private_subnet_1.id
}

output "priv_subnet_2" {
    value = aws_subnet.private_subnet_2.id
}