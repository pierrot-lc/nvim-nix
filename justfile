cachix-push:
    nix build --json | jq -r '.[].outputs | to_entries[].value' | cachix push pierrot-lc

pin-lock:
    git add flake.lock
    git commit -m "pin: update flake.lock"
    git push
