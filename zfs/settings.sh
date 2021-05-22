# will require sudo

zpool create \
	-o ashift=12 \
	-o listsnapshots=on \
	-O atime=off \
	-O compression=lz4 \
	<pool> <vdevs>

# if initializing on linux, disable features for O3X RW compatibility
## features as of OpenZFS 0.8.3:
	-o feature@project_quota=disabled \
	-o feature@userobj_accounting=disabled \


# if the vdevs use ssds
zpool set autotrim=on <pool>

# treat pool as a pure container
zfs set canmount=off <pool>

zfs create \
	-o encryption=aes-128-gcm \
	-o keyformat=passphrase \
	-o keylocation=prompt \
	-o pbkdf2iters=1M \
	<pool>/backups

# inherits encryption
zfs create <pool>/backups/<machine>

zfs set quota=<...> <pool>/backups/<machine>


# disable spotlight indexing on macos
	-o com.apple.browse=off
zfs set com.apple.browse=off <pool>/backups

## prevents index files from taking space in snapshots
mdutil -X <abspath>
touch <path>/.metadata_never_index
## https://apple.stackexchange.com/a/81737
touch <path>/.fseventsd/no_log
