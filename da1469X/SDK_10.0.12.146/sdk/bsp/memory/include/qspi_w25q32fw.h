/**
 * \addtogroup PLA_BSP_SYSTEM
 * \{
 * \addtogroup PLA_MEMORY
 *
 * \{
 */

/**
 ****************************************************************************************
 *
 * @file qspi_w25q32fw.h
 *
 * @brief QSPI flash driver for the Winbond W25Q32FW
 *
 * Copyright (C) 2017-2022 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 ****************************************************************************************
 */
#ifndef _QSPI_W32Q32FW_H_
#define _QSPI_W32Q32FW_H_

#ifndef WINBOND_ID
#define WINBOND_ID      0xEF
#endif

// Device type using command 0x9F
#define W25Q32FW        0x60

#ifndef W25Q_32Mb_SIZE
#define W25Q_32Mb_SIZE   0x16
#endif

#include "qspi_common.h"
#include "sdk_defs.h"

#include "qspi_winbond.h"

static void flash_w25q32fw_sys_clock_cfg(__UNUSED HW_QSPIC_ID id, __UNUSED sys_clk_t sys_clk);
static uint8_t flash_w25q32fw_get_dummy_bytes(__UNUSED HW_QSPIC_ID id, __UNUSED sys_clk_t sys_clk);

static const qspi_flash_config_t flash_w25q32fw_config = {
        .manufacturer_id                  = WINBOND_ID,
        .device_type                      = W25Q32FW,
        .device_density                   = W25Q_32Mb_SIZE,
        .is_suspended                     = flash_w25q_is_suspended,
        .initialize                       = flash_w25q_initialize,
        .sys_clk_cfg                      = flash_w25q32fw_sys_clock_cfg,
        .get_dummy_bytes                  = flash_w25q32fw_get_dummy_bytes,
        .break_seq_size                   = HW_QSPI_BREAK_SEQ_SIZE_1B,
        .address_size                     = HW_QSPI_ADDR_SIZE_24,
        .page_program_opcode              = CMD_QUAD_PAGE_PROGRAM,
        .page_qpi_program_opcode          = CMD_QPI_PAGE_PROGRAM,
        .quad_page_program_address        = false,
        .fast_read_opcode                 = CMD_FAST_READ_QUAD,
        .erase_opcode                     = CMD_SECTOR_ERASE,
        .erase_suspend_opcode             = W25Q_ERASE_PROGRAM_SUSPEND,
        .erase_resume_opcode              = W25Q_ERASE_PROGRAM_RESUME,
        .read_erase_progress_opcode       = CMD_READ_STATUS_REGISTER,
        .erase_in_progress_bit            = FLASH_STATUS_BUSY_BIT,
        .erase_in_progress_bit_high_level = true,
        .send_once                        = 1,
        .extra_byte                       = 0xA0,
        .ucode_wakeup                     = {w25q_ucode_wakeup, sizeof(w25q_ucode_wakeup)},
        .power_down_delay                 = W25Q_POWER_DOWN_DELAY_US,
        .release_power_down_delay         = W25Q_RELEASE_POWER_DOWN_DELAY_US,
        .power_up_delay                   = W25Q_POWER_UP_DELAY_US,
        .suspend_delay_us                 = 100,
        .resume_delay_us                  = 1,     // 200nsec
        .reset_delay_us                   = 30,
        .read_cs_idle_delay_ns            = 50,
        .erase_cs_idle_delay_ns           = 50,
        .is_ram                           = false,
        .qpi_mode                         = false,
        .enter_qpi_opcode                 = CMD_ENTER_QPI_MODE,
        .memory_size                      = MEMORY_SIZE_32Mb,
};

__RETAINED_CODE static void flash_w25q32fw_sys_clock_cfg(__UNUSED HW_QSPIC_ID id, __UNUSED sys_clk_t sys_clk)
{

}

__RETAINED_CODE static uint8_t flash_w25q32fw_get_dummy_bytes(__UNUSED HW_QSPIC_ID id, __UNUSED sys_clk_t sys_clk)
{
        return 2;
}

#if (dg_configUSE_SEGGER_FLASH_LOADER == 1) && (dg_configFLASH_AUTODETECT == 0)
__attribute__((used, __section__("__product_header_primary__")))
static const PRODUCT_HEADER_STRUCT(3) ph_primary = {
        .burstcmdA = 0xA82000EB,
        .burstcmdB = 0x00000066,
        .flash_config_section = 0x11AA,
        .flash_config_length = 0x3,
        .config_seq = {0x31, 0x02, 0x07},
        .crc = 0x15AD
};

__attribute__((used, __section__("__product_header_backup__")))
static const PRODUCT_HEADER_STRUCT(3) ph_backup = {
        .burstcmdA = 0xA82000EB,
        .burstcmdB = 0x00000066,
        .flash_config_section = 0x11AA,
        .flash_config_length = 0x3,
        .config_seq = {0x31, 0x02, 0x07},
        .crc = 0x15AD
};
#endif /* (dg_configUSE_SEGGER_FLASH_LOADER == 1) &&  (dg_configFLASH_AUTODETECT == 0) */

#endif /* _QSPI_W32Q32FW_H_ */
/**
 * \}
 * \}
 */
