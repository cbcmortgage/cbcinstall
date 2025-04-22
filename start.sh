#!/bin/bash

set -e

echo -e "\n*** Updating APT Catalog\n"
apt update

echo -e "\n\n*** Installing openssh\n"
apt install -y openssh-client

echo -e "\n\n*** Generating Key\n";

KEY_PATH="$HOME/.ssh/id_ed25519"

# Step 1: Create .ssh directory if it doesn't exist
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# Step 2: Generate ed25519 key with no passphrase
if [[ -f "$KEY_PATH" ]]; then
    echo "Key already exists at $KEY_PATH — aborting to prevent overwrite."
    exit 1
fi

ssh-keygen -t ed25519 -f "$KEY_PATH" -C "$USER@$(hostname)" -N ""

# Step 3: Ensure correct permissions
chmod 600 "$KEY_PATH"
chmod 644 "$KEY_PATH.pub"

# Step 4: Confirm default identity is set
if ! grep -q "$KEY_PATH" "$HOME/.ssh/config" 2>/dev/null; then
    echo "Updating ~/.ssh/config to use this key as default..."
    cat >> "$HOME/.ssh/config" <<EOF

Host github.com
    IdentityFile $KEY_PATH
    IdentitiesOnly yes
EOF
    chmod 600 "$HOME/.ssh/config"
fi

echo "*** SSH key created and set as default for github.com."

echo -e "\n\nPlease add this deploy key to the --> cbcmortgage <-- repo:\n\n"
cat /root/.ssh/id_ed25519.pub

echo ">>> When you are done, Press Enter to continue >>>"
read

git clone git@github.com:cbcmortgage/cbclms.git

bash cbcmortgage/install_cbc_1.sh
