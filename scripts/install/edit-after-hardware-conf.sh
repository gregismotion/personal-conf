if [[ -v EDIT_AFTER_HARDWARE_CONF ]]; then
	$EDITOR $EDIT_AFTER_HARDWARE_CONF
else
	echo "EDIT_AFTER_HARDWARE_CONF not set, continuing..."
fi
