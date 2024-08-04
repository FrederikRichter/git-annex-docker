{
  description = "Git Annex Docker image based on NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/05405724efa137a0b899cce5ab4dde463b4fd30b";
  };

  outputs = { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in
    {
      packages.x86_64-linux.default = pkgs.dockerTools.buildLayeredImage {
        name = "git-annex";
        tag = "latest";
        contents = with pkgs; [
          git
          git-annex
          bash
          coreutils
          gnupg
          openssh
          findutils
          bup
        ];
        config = {
          Cmd = [ "${pkgs.git-annex}/bin/git-annex" ];
          WorkingDir = "/data";
          Volumes = {
            "/data" = {};
          };
        };
      };
    };
}
