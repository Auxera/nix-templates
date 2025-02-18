{
  description = "Nix template collection";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        formatter = pkgs.alejandra;
        devShells.default = pkgs.mkShell rec {
          packages = with pkgs; [
            alejandra
          ];
        };
        templates = {
          node = {
            description = "Nodejs 22";
            path = ./node;
          };
          ruby = {
            description = "Ruby 3.4";
            path = ./ruby;
          };
        };
      }
    );
}
