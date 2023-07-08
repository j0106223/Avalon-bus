#!/bin/sh
sopc-create-header-files \
"${SOCEDS_DEST_ROOT}/HPS_LED_HEX/LED_HEX_hardware/soc_system.sopcinfo" \
--single hps_0.h \
--module hps_0
