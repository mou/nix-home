{
  lib,
  fetchFromGitHub,
  rustPlatform,
}: {
  obsidian-export = rustPlatform.buildRustPackage rec {
    pname = "obsidian-export";
    version = "v22.1.0";
    src = fetchFromGitHub {
      owner = "zoni";
      repo = pname;
      rev = version;
      sha256 = "sha256-/FspfEQdXKht99W404J4msRbwvDodqnwltQbx3YM/Ak=";
    };
    cargoSha256 = "sha256-FeeVwH5Nus4MPpOPLZvYjrziRqOBHoaj9jJ21e1DrF0=";
    meta = with lib; {
      description = "Rust library and CLI to export an Obsidian vault to regular Markdown";
      homepage = "https://github.com/zoni/obsidian-export";
      license = licenses.afl20;
    };
  };
}
