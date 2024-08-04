{
  description = "Git Annex Docker image based on NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.inputs.nixpkgs.url = "github:NixOS/nixpkgs/commit/05405724efa137a0b899cce5ab4dde463b4fd30b";
  };

  outputs = { self, nixpkgs, ... }@inputs:
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
