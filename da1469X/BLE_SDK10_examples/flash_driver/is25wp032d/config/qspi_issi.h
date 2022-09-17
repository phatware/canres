/**
 ****************************************************************************************
 *
 * @file qspi_issi.h
 *
 * @brief QSPI flash driver for ISSI flashes - common code
 *
 * Copyright (C) 2016-2020 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 ****************************************************************************************
 */
#ifndef _QSPI_ISSI_H_
#define _QSPI_ISSI_H_

#define ISSI_ID    0x9D

#include "sdk_defs.h"
#include "qspi_common.h"

#define ISSI_ERASE_PROGRAM_SUSPEND                                      0x75
#define ISSI_ERASE_PROGRAM_RESUME                                       0x7A
#define ISSI_WRITE_STATUS_REGISTER                                      0x01
#define ISSI_READ_FUNCTION_REGISTER                                     0x48
#define ISSI_WRITE_FUNCTION_REGISTER                                    0x42
#define ISSI_QUAD_IO_PAGE_PROGRAM                                       0x38

#define ISSI_STATUS_QE_BIT                                              6 // Quad Enable
#define ISSI_STATUS_QE_MASK                                             (1 << ISSI_STATUS_QE_BIT)

/* Suspend Bits on Function Register */
#define ISSI_STATUS_PSUS_BIT                                            2 // Program suspend bit
#define ISSI_STATUS_PSUS_MASK                                           (1 << ISSI_STATUS_PSUS_BIT)
#define ISSI_STATUS_ESUS_BIT                                            3 // Erase suspend bit
#define ISSI_STATUS_ESUS_MASK                                           (1 << ISSI_STATUS_ESUS_BIT)


__STATIC_FORCEINLINE __UNUSED void flash_issi_write_status_register(HW_QSPIC_ID id, uint8_t value)
{
        uint8_t cmd[] = { ISSI_WRITE_STATUS_REGISTER, value};

        flash_write(id, cmd, 2);

        /* Wait for the Flash to process the command */
        while (flash_is_busy(id));
}


__STATIC_FORCEINLINE __UNUSED uint8_t flash_issi_read_function_register(HW_QSPIC_ID id)
{
        __DBG_QSPI_VOLATILE__ uint8_t status;
        uint8_t cmd[] = { ISSI_READ_FUNCTION_REGISTER };

        flash_transact(id, cmd, 1, &status, 1);

        return status;
}

__STATIC_FORCEINLINE __UNUSED void flash_issi_write_function_register(HW_QSPIC_ID id, uint8_t value)
{
        uint8_t cmd[] = { ISSI_WRITE_FUNCTION_REGISTER, value};

        flash_write(id, cmd, 2);

        /* Wait for the Flash to process the command */
        while (flash_is_busy(id));
}

__STATIC_FORCEINLINE void flash_issi_enable_quad_mode(HW_QSPIC_ID id)
{
        uint16_t status;

        status = flash_read_status_register(id);

        if (!(status & ISSI_STATUS_QE_MASK)) {
                flash_write_enable(id);
                flash_issi_write_status_register(id, status | ISSI_STATUS_QE_MASK);
        }
}

__RETAINED_CODE static bool flash_issi_is_suspended(HW_QSPIC_ID id)
{
        __DBG_QSPI_VOLATILE__ uint8_t status;

        status = flash_issi_read_function_register(id);
        return (status & (ISSI_STATUS_PSUS_MASK | ISSI_STATUS_ESUS_MASK)) != 0;
}

#endif /* _QSPI_ISSI_H_ */
/**
 * \}
 * \}
 */
