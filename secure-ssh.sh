# secure-ssh.sh
# Author firelily20

# Creates a new user called $user
# Adds a public key to the authorized key file
echo "What user do you want to add?"
read user
useradd $user

mkdir /home/$user/.ssh
cp linux/public-keys/sys265.pub /home/$user/.ssh/authorized_keys

chmod 700 /home/$user/.ssh
chmod 600 /home/$user/.ssh/authorized_keys
chown -R $user:$user /home/$user/.ssh

echo "Created the user and moved the rsa key file"

# Removes roots ability to ssh in
echo "Removing roots ability to ssh in"

sed 's/#\?\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config > temp.txt 
mv -f temp.txt /etc/ssh/sshd_config

echo "Root should no longer be able to ssh in"
