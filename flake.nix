{
  description = "Git Annex Docker image based on NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.dockerTools.buildLayeredImage {
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
      }
    );
}
