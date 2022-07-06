if [ -z "${EDIT_AFTER_HARDWARE_CONF+x}" ]; then
	echo "EDIT_AFTER_HARDWARE_CONF not set, continuing..."
else
	$EDITOR $EDIT_AFTER_HARDWARE_CONF
fi
