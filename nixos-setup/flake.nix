{
  description = "Hery's NixOS WSL Flake";

  # This is the standard format for declaring your dependencies (inputs)
  inputs = {
    # Nixpkgs: The official NixOS package source.
    # (Using nixos-unstable here for rolling release, but you can change it to a specific version like nixos-24.05)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Add the NixOS-WSL input
    nixos-wsl.url = "github:nix-community/NixOS-WSL.main";

    # Home Manager: Manages user packages
    home-manager = {
      url = "github:nix-community/home-manager";
      # Tells Home Manager to use the exact same nixpkgs version as the system
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # The outputs are the actual systems and configurations built from your inputs
  outputs = { self, nixos-wsl, nixpkgs, home-manager, ... }@inputs: {

    nixosConfigurations = {
      # "nixos-laptop" MUST match the networking.hostName defined in your configuration.nix
      "nixos-laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # Pass the inputs to our modules so they can be used if needed
        specialArgs = { inherit inputs; };

        # These are the building blocks of your system
        modules = [
          # 1. Import the WSL module natively
          nixos-wsl.nixosModules.default

          # 2. Your system configuration (the file we built earlier)
          ./nixos/configuration.nix
          ./nixos/pkgs.nix

          # 3. Home Manager integrated directly into the OS build
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # We defined the actual user packages (git, nvim, zsh) inside configuration.nix earlier,
            # so Home Manager will pick them up automatically from there.
          }
        ];
      };
    };
  };
}