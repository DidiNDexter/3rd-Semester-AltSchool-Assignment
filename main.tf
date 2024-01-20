module "networking" {
  source              = "./modules/networking"
  cidr_block          = "192.168.0.0/16"
  enviroment          = "root"
  public_subnet_cidr  = "192.168.2.0/24"
  az                  = "eu-west-2a"
  az_private_subnet   = "eu-west-2b"
  private_subnet_cidr = "192.168.3.0/24"

}

module "compute" {
  source          = "./modules/compute"
  enviroment      = "root"
  public_key_path = "~/.ssh/didi_key.pub"
  volume_size     = "20"
  public_subnet   = module.networking.test_public_subnet
  public_sg       = module.networking.allow_all
  key_name        = "didi_key"
  instance_type   = "t2.micro"
}
