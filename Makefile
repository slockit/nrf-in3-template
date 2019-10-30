PROJECT_NAME     := nrf_in3
TARGETS          := nrf52840_xxaa
OUTPUT_DIRECTORY := build

PROJ_DIR := .
SRC_DIR := $(PROJ_DIR)/src
INC_DIR := $(PROJ_DIR)/include
LIB_DIR := $(PROJ_DIR)/lib

# CHAIN ID are dependable on in3 contract deployed on said chain.
# Check https://git.slock.it/in3/src/c/in3-core/blob/develop/src/core/client/client_init.c
# 0x1: Mainnet, the Ethereum public PoW network
# 0x5: Goerli, the public cross-client PoA testnet
# 0x42: Kovan, the public Parity-only PoA testnet
# 0x7d0: IPFS, ?
IN3_CHAIN_ID := 0x5
# NANO | BASIC | FULL
IN3_VERSION := FULL
# UART | BLE
IN3_TRANSPORT := UART

$(OUTPUT_DIRECTORY)/nrf52840_xxaa.out: \
  LINKER_SCRIPT  := ./src/nrf_in3.ld

# Source files common to all targets
SRC_FILES += \
	$(wildcard $(SRC_DIR)/*.c) \
	$(wildcard $(SRC_DIR)/transport/ble/*.c) \
	$(wildcard $(SRC_DIR)/transport/mock/*.c) \
	$(wildcard $(SRC_DIR)/transport/uart/*.c) \
  $(SDK_ROOT)/modules/nrfx/mdk/gcc_startup_nrf52840.S \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_rtt.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_serial.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_uart.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_default_backends.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_frontend.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_str_formatter.c \
	$(SDK_ROOT)/components/libraries/mem_manager/mem_manager.c \
  $(SDK_ROOT)/components/boards/boards.c \
  $(SDK_ROOT)/components/libraries/util/app_error.c \
  $(SDK_ROOT)/components/libraries/util/app_error_handler_gcc.c \
  $(SDK_ROOT)/components/libraries/util/app_error_weak.c \
  $(SDK_ROOT)/components/libraries/util/app_util_platform.c \
  $(SDK_ROOT)/components/libraries/util/nrf_assert.c \
  $(SDK_ROOT)/components/libraries/atomic/nrf_atomic.c \
  $(SDK_ROOT)/components/libraries/balloc/nrf_balloc.c \
  $(SDK_ROOT)/external/fprintf/nrf_fprintf.c \
  $(SDK_ROOT)/external/fprintf/nrf_fprintf_format.c \
  $(SDK_ROOT)/components/libraries/memobj/nrf_memobj.c \
  $(SDK_ROOT)/components/libraries/ringbuf/nrf_ringbuf.c \
  $(SDK_ROOT)/components/libraries/strerror/nrf_strerror.c \
  $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_uart.c \
	$(SDK_ROOT)/components/libraries/uart/retarget.c \
	$(SDK_ROOT)/components/libraries/uart/app_uart_fifo.c \
	$(SDK_ROOT)/components/libraries/fifo/app_fifo.c \
  $(SDK_ROOT)/modules/nrfx/soc/nrfx_atomic.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/prs/nrfx_prs.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_uart.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_uarte.c \
  $(SDK_ROOT)/modules/nrfx/mdk/system_nrf52840.c \
	$(SDK_ROOT)/components/libraries/button/app_button.c \
	$(SDK_ROOT)/components/libraries/scheduler/app_scheduler.c \
	$(SDK_ROOT)/components/libraries/timer/app_timer.c \
	$(SDK_ROOT)/components/libraries/hardfault/hardfault_implementation.c \
	$(SDK_ROOT)/components/libraries/atomic_fifo/nrf_atfifo.c \
	$(SDK_ROOT)/components/libraries/atomic_flags/nrf_atflags.c \
	$(SDK_ROOT)/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c \
	$(SDK_ROOT)/components/libraries/experimental_section_vars/nrf_section_iter.c \
	$(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_clock.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_clock.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_gpiote.c \
	$(SDK_ROOT)/components/libraries/bsp/bsp.c \
	$(SDK_ROOT)/components/libraries/bsp/bsp_btn_ble.c \
	$(SDK_ROOT)/components/ble/common/ble_advdata.c \
	$(SDK_ROOT)/components/ble/ble_advertising/ble_advertising.c \
	$(SDK_ROOT)/components/ble/common/ble_conn_params.c \
	$(SDK_ROOT)/components/ble/common/ble_conn_state.c \
	$(SDK_ROOT)/components/ble/ble_link_ctx_manager/ble_link_ctx_manager.c \
	$(SDK_ROOT)/components/ble/common/ble_srv_common.c \
	$(SDK_ROOT)/components/ble/nrf_ble_gatt/nrf_ble_gatt.c \
	$(SDK_ROOT)/components/ble/nrf_ble_qwr/nrf_ble_qwr.c \
	$(SDK_ROOT)/external/utf_converter/utf.c \
	$(SDK_ROOT)/components/ble/ble_services/ble_nus/ble_nus.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_printf.c \
  $(SDK_ROOT)/components/ble/ble_services/ble_nus/ble_nus.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c \
  $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT.c \
  $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c \
	$(SDK_ROOT)/components/libraries/bsp/bsp_nfc.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_init.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_rng.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_rng_mbedtls.c \
	$(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_rng.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_nfct.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_rng.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_timer.c \
	$(SDK_ROOT)/components/libraries/crc16/crc16.c \
	$(SDK_ROOT)/components/libraries/ecc/ecc.c \
	$(SDK_ROOT)/components/libraries/fds/fds.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_sd.c \
	$(SDK_ROOT)/components/libraries/queue/nrf_queue.c \
	$(SDK_ROOT)/components/libraries/sensorsim/sensorsim.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_aead.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_aes.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_aes_shared.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecdh.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecdsa.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_eddsa.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_error.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_hash.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_hkdf.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_hmac.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_init.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_rng.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_shared.c \
	$(SDK_ROOT)/external/mbedtls/library/aes.c \
	$(SDK_ROOT)/external/mbedtls/library/ctr_drbg.c \
	$(SDK_ROOT)/components/ble/peer_manager/auth_status_tracker.c \
	$(SDK_ROOT)/components/ble/peer_manager/gatt_cache_manager.c \
	$(SDK_ROOT)/components/ble/peer_manager/gatts_cache_manager.c \
	$(SDK_ROOT)/components/ble/peer_manager/id_manager.c \
	$(SDK_ROOT)/components/ble/peer_manager/nrf_ble_lesc.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_data_storage.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_database.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_id.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_manager.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_manager_handler.c \
	$(SDK_ROOT)/components/ble/peer_manager/pm_buffer.c \
	$(SDK_ROOT)/components/ble/peer_manager/security_dispatcher.c \
	$(SDK_ROOT)/components/ble/peer_manager/security_manager.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_aes.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_aes_aead.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_chacha_poly_aead.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_ecdh.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_ecdsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_eddsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_hash.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_hmac.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_init.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_mutex.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_rng.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_shared.c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ac_rec/nfc_ac_rec.c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_oob_advdata/nfc_ble_oob_advdata.c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/common/nfc_ble_pair_common.c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_pair_lib/nfc_ble_pair_lib.c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_pair_msg/nfc_ble_pair_msg.c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ep_oob_rec/nfc_ep_oob_rec.c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/hs_rec/nfc_hs_rec.c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/le_oob_rec/nfc_le_oob_rec.c \
	$(SDK_ROOT)/components/nfc/ndef/generic/message/nfc_ndef_msg.c \
	$(SDK_ROOT)/components/nfc/ndef/generic/record/nfc_ndef_record.c \
	$(SDK_ROOT)/components/nfc/platform/nfc_platform.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_printf.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_chacha_poly_aead.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecdh.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecdsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_eddsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_hash.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_hmac.c \


# Include folders common to all targets
INC_FOLDERS += \
  $(SDK_ROOT)/external/fprintf \
  $(SRC_DIR)/transport/ble \
	$(SRC_DIR)/transport/mock \
	$(SRC_DIR)/transport/uart \
 	$(SRC_DIR)/in3/include/ \
  $(SDK_ROOT)/components/libraries/experimental_section_vars \
  $(SDK_ROOT)/external/nrf_cc310/include \
  $(SDK_ROOT)/components/libraries/atomic \
  $(SDK_ROOT)/components/libraries/delay \
  ./config \
  $(SDK_ROOT)/components/toolchain/cmsis/include \
  $(SDK_ROOT)/components/libraries/balloc \
  $(SDK_ROOT)/components/libraries/log \
  $(SDK_ROOT)/components/libraries/memobj \
	$(SDK_ROOT)/components/libraries/mem_manager/ \
	$(SDK_ROOT)/components/libraries/uart \
	$(SDK_ROOT)/components/libraries/fifo \
	$(SDK_ROOT)/components/libraries/balloc \
  $(SDK_ROOT)/components/libraries/ringbuf \
  $(SDK_ROOT)/modules/nrfx/hal \
  $(SDK_ROOT)/components/libraries/bsp \
  $(SDK_ROOT)/components \
  $(SDK_ROOT)/modules/nrfx/mdk \
  $(SDK_ROOT)/components/libraries/strerror \
  $(SDK_ROOT)/integration/nrfx \
  $(SDK_ROOT)/modules/nrfx/drivers/include \
  $(SDK_ROOT)/components/libraries/ringbuf \
  $(SDK_ROOT)/modules/nrfx \
  $(SDK_ROOT)/components/libraries/log/src \
  $(SDK_ROOT)/modules/nrfx/hal \
  $(SDK_ROOT)/components/libraries/bsp \
  $(SDK_ROOT)/components/boards \
  $(SDK_ROOT)/integration/nrfx/legacy \
  $(SDK_ROOT)/components/libraries/util \
  $(SDK_ROOT)/external/nrf_cc310/common \
	$(SDK_ROOT)/external/segger_rtt \
	$(SDK_ROOT)/components/ble/ble_services/ble_cscs \
	$(SDK_ROOT)/components/libraries/hci \
	$(SDK_ROOT)/components/libraries/usbd/class/hid/kbd \
	$(SDK_ROOT)/components/libraries/timer \
	$(SDK_ROOT)/components/softdevice/s140/headers \
	$(SDK_ROOT)/components/nfc/t4t_parser/tlv \
	$(SDK_ROOT)/components/libraries/sortlist \
	$(SDK_ROOT)/components/libraries/spi_mngr \
	$(SDK_ROOT)/components/libraries/led_softblink \
	$(SDK_ROOT)/components/nfc/ndef/conn_hand_parser \
	$(SDK_ROOT)/components/libraries/sdcard \
	$(SDK_ROOT)/components/nfc/ndef/parser/record \
	$(SDK_ROOT)/components/ble/ble_link_ctx_manager \
	$(SDK_ROOT)/components/ble/ble_services/ble_nus \
	$(SDK_ROOT)/components/libraries/twi_mngr \
	$(SDK_ROOT)/components/ble/ble_services/ble_hids \
	$(SDK_ROOT)/components/libraries/crc32 \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_oob_advdata \
	$(SDK_ROOT)/components/nfc/t2t_parser \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_pair_msg \
	$(SDK_ROOT)/components/libraries/usbd/class/audio \
	$(SDK_ROOT)/components/nfc/t4t_lib \
	$(SDK_ROOT)/components/ble/peer_manager \
	$(SDK_ROOT)/components/libraries/mem_manager \
	$(SDK_ROOT)/components/ble/ble_services/ble_tps \
	$(SDK_ROOT)/components/nfc/ndef/parser/message \
	$(SDK_ROOT)/components/ble/ble_services/ble_dis \
	$(SDK_ROOT)/components/nfc/ndef/uri \
	$(SDK_ROOT)/components/ble/nrf_ble_gatt \
	$(SDK_ROOT)/components/ble/nrf_ble_qwr \
	$(SDK_ROOT)/components/libraries/gpiote \
	$(SDK_ROOT)/components/libraries/button \
	$(SDK_ROOT)/components/libraries/twi_sensor \
	$(SDK_ROOT)/components/libraries/usbd \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ep_oob_rec \
	$(SDK_ROOT)/components/libraries/atomic_fifo \
	$(SDK_ROOT)/components/ble/ble_services/ble_lbs_c \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_pair_lib \
	$(SDK_ROOT)/components/libraries/crypto \
	$(SDK_ROOT)/components/ble/ble_racp \
	$(SDK_ROOT)/components/libraries/fds \
	$(SDK_ROOT)/components/nfc/ndef/launchapp \
	$(SDK_ROOT)/components/libraries/atomic_flags \
	$(SDK_ROOT)/components/ble/ble_services/ble_hrs \
	$(SDK_ROOT)/components/ble/ble_services/ble_rscs \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/hs_rec \
	$(SDK_ROOT)/components/nfc/ndef/conn_hand_parser/ac_rec_parser \
	$(SDK_ROOT)/components/libraries/stack_guard \
	$(SDK_ROOT)/components/nfc/ndef/conn_hand_parser/le_oob_rec_parser \
	$(SDK_ROOT)/components/ble/ble_services/ble_gls \
	$(SDK_ROOT)/components/libraries/fstorage \
	$(SDK_ROOT)/components/nfc/ndef/text \
	$(SDK_ROOT)/components/libraries/mutex \
	$(SDK_ROOT)/components/libraries/gfx \
	$(SDK_ROOT)/components/libraries/bootloader/ble_dfu \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/common \
	$(SDK_ROOT)/components/nfc/ndef/generic/record \
	$(SDK_ROOT)/components/nfc/t4t_parser/cc_file \
	$(SDK_ROOT)/components/ble/ble_advertising \
	$(SDK_ROOT)/external/utf_converter \
	$(SDK_ROOT)/components/ble/ble_services/ble_bas_c \
	$(SDK_ROOT)/components/libraries/experimental_task_manager \
	$(SDK_ROOT)/components/ble/ble_services/ble_hrs_c \
	$(SDK_ROOT)/components/softdevice/s140/headers/nrf52 \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/le_oob_rec \
	$(SDK_ROOT)/components/libraries/queue \
	$(SDK_ROOT)/components/libraries/pwr_mgmt \
	$(SDK_ROOT)/components/ble/ble_dtm \
	$(SDK_ROOT)/components/ble/ble_services/ble_rscs_c \
	$(SDK_ROOT)/components/ble/common \
	$(SDK_ROOT)/components/ble/ble_services/ble_lls \
	$(SDK_ROOT)/components/nfc/ndef/connection_handover/ac_rec \
	$(SDK_ROOT)/components/ble/ble_services/ble_bas \
	$(SDK_ROOT)/components/libraries/mpu \
	$(SDK_ROOT)/components/ble/ble_services/ble_ans_c \
	$(SDK_ROOT)/components/libraries/slip \
	$(SDK_ROOT)/components/libraries/csense_drv \
	$(SDK_ROOT)/components/ble/ble_services/ble_nus_c \
	$(SDK_ROOT)/components/softdevice/common \
	$(SDK_ROOT)/components/ble/ble_services/ble_ias \
	$(SDK_ROOT)/components/libraries/usbd/class/hid/mouse \
	$(SDK_ROOT)/components/libraries/low_power_pwm \
	$(SDK_ROOT)/components/nfc/ndef/conn_hand_parser/ble_oob_advdata_parser \
	$(SDK_ROOT)/components/ble/ble_services/ble_dfu \
	$(SDK_ROOT)/components/libraries/svc \
	$(SDK_ROOT)/components/libraries/scheduler \
	$(SDK_ROOT)/components/libraries/cli \
	$(SDK_ROOT)/components/ble/ble_services/ble_lbs \
	$(SDK_ROOT)/components/ble/ble_services/ble_hts \
	$(SDK_ROOT)/components/ble/ble_services/ble_cts_c \
	$(SDK_ROOT)/components/libraries/crc16 \
	$(SDK_ROOT)/components/nfc/t4t_parser/apdu \
	$(SDK_ROOT)/components/libraries/usbd/class/cdc \
	$(SDK_ROOT)/components/libraries/csense \
	$(SDK_ROOT)/components/libraries/ecc \
	$(SDK_ROOT)/components/libraries/hardfault \
	$(SDK_ROOT)/components/nfc/ndef/generic/message \
	$(SDK_ROOT)/components/nfc/t2t_lib \
	$(SDK_ROOT)/components/nfc/t4t_parser/hl_detection_procedure \
	$(SDK_ROOT)/components/ble/ble_services/ble_ancs_c \
	$(SDK_ROOT)/components/ble/ble_services/ble_ias_c \
	$(SDK_ROOT)/components/libraries/pwm \
	$(SDK_ROOT)/components/libraries/usbd/class/cdc/acm \
	$(SDK_ROOT)/components/libraries/usbd/class/hid/generic \
	$(SDK_ROOT)/components/libraries/usbd/class/msc \
	$(SDK_ROOT)/components/libraries/usbd/class/hid \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310 \
	$(SDK_ROOT)/external/nrf_oberon \
	$(SDK_ROOT)/external/nrf_oberon/include \
	$(SDK_ROOT)/external/micro-ecc/micro-ecc \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_sw \
	$(SDK_ROOT)/components/nfc/platform \
	$(SDK_ROOT)/external/nrf_tls/mbedtls/nrf_crypto/config \
	$(SDK_ROOT)/components/libraries/crypto/backend/cifra \
	$(SDK_ROOT)/components/libraries/stack_info \
	$(SDK_ROOT)/components/libraries/crypto/backend/optiga \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc \
	$(SDK_ROOT)/external/mbedtls/include \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310_bl \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw \
	$(SDK_ROOT)/components/libraries/sensorsim \
	$(SDK_ROOT)/components/libraries/crypto/backend/mbedtls \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon \

# Libraries common to all targets
LIB_FILES += \
  $(SDK_ROOT)/external/nrf_cc310/lib/cortex-m4/hard-float/libnrf_cc310_0.9.12.a \
	$(SDK_ROOT)/external/nrf_oberon/lib/cortex-m4/hard-float/liboberon_2.0.7.a \
	$(SDK_ROOT)/external/micro-ecc/nrf52hf_armgcc/armgcc/micro_ecc_lib_nrf52.a \
	$(SDK_ROOT)/components/nfc/t2t_lib/nfc_t2t_lib_gcc.a \

# Optimization flags
OPT = -Os -g3
# Uncomment the line below to enable link time optimization
#OPT += -flto

# C flags common to all targets
CFLAGS += $(OPT)
CFLAGS += -DIN3_VERSION_$(IN3_VERSION)
CFLAGS += -DIN3_TRANSPORT_$(IN3_TRANSPORT)
CFLAGS += -DBOARD_PCA10059
CFLAGS += -DIN3_MATH_LITE
CFLAGS += -DCONFIG_GPIO_AS_PINRESET
CFLAGS += -DDEBUG
CFLAGS += -D__NRF_FREERTOS__
CFLAGS += -DFLOAT_ABI_HARD
CFLAGS += -DMBEDTLS_CONFIG_FILE=\"nrf_crypto_mbedtls_config.h\"
CFLAGS += -DNRF52840_XXAA
CFLAGS += -DNRF_CRYPTO_MAX_INSTANCE_COUNT=1
CFLAGS += -DNRF_SD_BLE_API_VERSION=6
CFLAGS += -DS140
CFLAGS += -DSOFTDEVICE_PRESENT
CFLAGS += -DSWI_DISABLE0
CFLAGS += -mcpu=cortex-m4
CFLAGS += -mthumb -mabi=aapcs
CFLAGS += -Wall
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# keep every function in a separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums

# C++ flags common to all targets
CXXFLAGS += $(OPT)

# Assembler flags common to all targets
ASMFLAGS += -g3
ASMFLAGS += -mcpu=cortex-m4
ASMFLAGS += -mthumb -mabi=aapcs
ASMFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
ASMFLAGS += -DBOARD_PCA10059
ASMFLAGS += -DCONFIG_GPIO_AS_PINRESET
ASMFLAGS += -DDEBUG
ASMFLAGS += -DDEBUG_NRF
ASMFLAGS += -DDX_CC_TEE
ASMFLAGS += -DFLOAT_ABI_HARD
ASMFLAGS += -DNRF52840_XXAA
ASMFLAGS += -DNRF_CRYPTO_MAX_INSTANCE_COUNT=1
ASMFLAGS += -DNRF_SD_BLE_API_VERSION=6
ASMFLAGS += -DS140
ASMFLAGS += -DSOFTDEVICE_PRESENT
ASMFLAGS += -DSWI_DISABLE0

# Linker flags
LDFLAGS += $(OPT)
LDFLAGS += -mthumb -mabi=aapcs -L$(SDK_ROOT)/modules/nrfx/mdk -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m4
LDFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# let linker dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
# LDFLAGS += --specs=nano.specs

nrf52840_xxaa: CFLAGS += -D__HEAP_SIZE=0
nrf52840_xxaa: CFLAGS += -D__STACK_SIZE=16384
nrf52840_xxaa: ASMFLAGS += -D__HEAP_SIZE=0
nrf52840_xxaa: ASMFLAGS += -D__STACK_SIZE=16384

# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
LIB_FILES += -lc -lnosys -lm


.PHONY: default help

# Default target - first one defined
default: check-in3 check-env copy-debug-header print-in3 nrf52840_xxaa

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		nrf52840_xxaa
	@echo		sdk_config - starting external tool for editing sdk_config.h
	@echo		flash      - flashing binary

TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc


include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

.PHONY: flash erase flash_softdevice debug debug-server sdk_config copy-debug-header check-env check-in3 print-in3

# Flash the program
flash: default
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52840_xxaa.hex
	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/nrf52840_xxaa.hex --sectorerase
	nrfjprog -f nrf52 --reset

erase:
	nrfjprog -f nrf52 --eraseall

# Flash softdevice
flash_softdevice:
	@echo Flashing: s140_nrf52_6.1.1_softdevice.hex
	nrfjprog -f nrf52 --program $(SDK_ROOT)/components/softdevice/s140/hex/s140_nrf52_6.1.1_softdevice.hex --sectorerase
	nrfjprog -f nrf52 --reset

check-in3:
	@echo Checking in3 version;
	if [ -d "$(SRC_DIR)/in3" ]; \
		then \
			echo "Dir exists"; \
		else \
			git clone https://github.com/slockit/in3-c.git $(SRC_DIR)/in3; \
	fi

copy-debug-header:
	cp $(SRC_DIR)/in3/src/core/util/debug.h $(SRC_DIR)/in3/include/in3/debug.h
	$(eval SRC_FILES+=$(wildcard $(SRC_DIR)/in3/src/api/eth1/*.c) \
		$(wildcard $(SRC_DIR)/in3/src/core/client/*.c) \
		$(wildcard $(SRC_DIR)/in3/src/core/util/*.c) \
		$(wildcard $(SRC_DIR)/in3/src/third-party/crypto/*.c) \
		$(wildcard $(SRC_DIR)/in3/src/third-party/tommath/*.c) \
		$(wildcard $(SRC_DIR)/in3/src/verifier/eth1/nano/*.c) \
		$(wildcard $(SRC_DIR)/in3/src/verifier/eth1/basic/*.c) \
		$(wildcard $(SRC_DIR)/in3/src/verifier/eth1/evm/*.c) \
		$(wildcard $(SRC_DIR)/in3/src/verifier/eth1/full/*.c))

print-in3:
	@echo Done
	@echo $(SRC_FILES)

debug-server:
	JLinkGDBServerCL -device nrf52840_xxaa -if swd -port 2331

debug:
	$(GNU_INSTALL_ROOT)arm-none-eabi-gdb $(OUTPUT_DIRECTORY)/$(TARGETS).out -x debug_cmds.txt

SDK_CONFIG_FILE := ../config/sdk_config.h
CMSIS_CONFIG_TOOL := $(SDK_ROOT)/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar
sdk_config:
	java -jar $(CMSIS_CONFIG_TOOL) $(SDK_CONFIG_FILE)

check-env:
ifndef SDK_ROOT
$(error Set environment variable 'SDK_ROOT' containing the NRF5 SDK folder path)
endif
ifndef GNU_INSTALL_ROOT
$(error Set environment variable 'GNU_INSTALL_ROOT' containing the toolchain folder path)
endif
