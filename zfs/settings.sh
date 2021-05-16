# will require sudo

zpool create \
	-o ashift=12 \
	-O atime=off \
	-O compression=lz4 \
	<pool> <vdevs>

zpool set listsnapshots=on <pool>


zfs create \
	-o encryption=aes-128-gcm \
	-o keyformat=passphrase \
	-o keylocation=prompt \
	-o pbkdf2iters=1000000 \
	<pool>/backups

# inherits encryption
zfs create <pool>/backups/<machine>
zfs set quota= <pool>/backups/<machine>
