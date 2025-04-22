echo -e "\n*** Updating APT Catalog\n"
apt update

echo -e "\n\n*** Installing openssh\n"
apt install -y openssh-client

echo -e "\n\n*** Generating Key\n";
ssh-keygen -t ed25519 -N \"\" -f ~/.ssh/id_ed25519
echo -e "\n\nPlease add this deploy key to the --> cbcmortgage <-- repo:\n\n"
cat /root/.ssh/id_ed25519.pub

echo ">>> When you are done, Press Enter to continue >>>"
read

git clone git@github.com:cbcmortgage/cbclms.git

bash cbcmortgage/install_cbc_1.sh
