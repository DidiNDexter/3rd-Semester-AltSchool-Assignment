module "networking" {
  source              = "../modules/networking"
  cidr_block          = "10.0.0.0/16"
  enviroment          = "dev"
  az                  = "eu-west-1a"
  az_private_subnet   = "eu-west-1b"
  public_subnet_cidr  = "10.0.2.0/24"
  private_subnet_cidr = "10.0.3.0/24"

}


module "compute" {
  source          = "./modules/compute"
  enviroment      = "dev"
  public_key_path = "~/.ssh/didi_key.pub"
  volume_size     = "20"
  public_subnet   = module.networking.test_public_subnet
  public_sg       = module.networking.allow_all
  key_name        = "didi_key"
  instance_type   = "t2.micro"
}
