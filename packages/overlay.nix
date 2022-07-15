[
  (final: prev: {
    vimPlugins = prev.vimPlugins // (prev.callPackage ./vimPlugins.nix {});
  })
  (final: prev: {obsidian-export = (prev.callPackage ./programs.nix {}).obsidian-export;})
]
