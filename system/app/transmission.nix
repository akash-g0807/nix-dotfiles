{config, pkgs, inputs, ... }:

{
   services.transmission = {
  enable = true;
  package = pkgs.transmission_4;
  settings = {
    download-dir = "${config.services.transmission.home}/Downloads";
};
};
}


