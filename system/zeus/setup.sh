ROOT=/setup
ROOT_SIZE=1G

RESERVED_SIZE=1G
SWAP_SIZE=16G

SYS_DISK=/dev/disk/by-id/ata-SAMSUNG_MZ7LN128HCHP-000H1_S1ZRNXAH270094
SYS_POOL=sys
SYS_LOCAL_POOL=${SYS_POOL}/local
SYS_SAFE_POOL=${SYS_POOL}/safe

DATA_DISK=/dev/disk/by-id/ata-WDC_WD4003FFBX-68MU3N0_VBHBMA5F
DATA_POOL=data
DATA_LOCAL_POOL=${DATA_POOL}/local
DATA_SAFE_POOL=${DATA_POOL}/safe

PREFIX=$(dirname $0)/../system/$HOST

EDITOR="vim" # FIXME: should be set by HM...
EDIT_AFTER_HARDWARE_CONF="${PREFIX}/hardware-configuration.nix ${PREFIX}/hardware-configuration-zfs.nix"

source ${PREFIX}/setup/root.sh
source ${PREFIX}/setup/sys.sh
source ${PREFIX}/setup/data.sh
