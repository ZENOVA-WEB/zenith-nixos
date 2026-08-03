{ config, pkgs, ... }:

{
  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    settings = {
      model = {
        provider = "openai";
        default = "omniroute-model";
        base_url = "http://localhost:20128/v1";
        api_key = "sk-2b2232da4206b71b-c84f4b-971c6451";
      };
    };
  };
}