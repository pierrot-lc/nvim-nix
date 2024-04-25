run:
    nix run .

cachix-push:
    nix build --json | jq -r '.[].outputs | to_entries[].value' | cachix push pierrot-lc

bundle:
    nix bundle --bundler github:DavHau/nix-portable -o bundle

pin-lock:
    git add flake.lock
    git commit -m "pin: update flake.lock"
    git push
