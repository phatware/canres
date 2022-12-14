/**
 ****************************************************************************************
 *
 * @file hogpbh.h
 *
 * @brief Header file - HID Over GATT Profile - Boot Host Role.
 *
 * Copyright (C) RivieraWaves 2009-2015
 *
 *
 ****************************************************************************************
 */


#ifndef _HOGPBH_H_
#define _HOGPBH_H_


/**
 ****************************************************************************************
 * @addtogroup HOGPBH HID Over GATT Profile Client
 * @ingroup HOGP
 * @brief HID Over GATT Profile Client
 * @{
 ****************************************************************************************
 */

/*
 * INCLUDE FILES
 ****************************************************************************************
 */

#if (BLE_HID_BOOT_HOST)

#include "hogp_common.h"
#include "ke_task.h"
#include "hogpbh_task.h"
#include "prf_types.h"
#include "prf_utils.h"
#include "prf.h"

/*
 * DEFINES
 ****************************************************************************************
 */


/*
 * MACROS
 ****************************************************************************************
*/

/*
 * ENUMERATIONS
 ****************************************************************************************
 */


/*
 * TYPE DEFINITIONS
 ****************************************************************************************
 */


/// Environment variable for each Connections
struct hogpbh_cnx_env
{
    /// on-going operation
    struct ke_msg * operation;
    ///HIDS characteristics
    struct hogpbh_content hids[HOGPBH_NB_HIDS_INST_MAX];
    ///Number of HIDS instances found
    uint8_t hids_nb;
};

/// HID Over Gatt Profile Boot Host environment variable
struct hogpbh_env_tag
{
    /// profile environment
    prf_env_t prf_env;
    /// Environment variable pointer for each connections
    struct hogpbh_cnx_env* env[HOGPBH_IDX_MAX];
    /// State of different task instances
    ke_state_t state[HOGPBH_IDX_MAX];
};

/*
 * GLOBAL VARIABLE DECLARATIONS
 ****************************************************************************************
 */

/*
 * GLOBAL FUNCTIONS DECLARATIONS
 ****************************************************************************************
 */


/**
 ****************************************************************************************
 * @brief Retrieve HID boot host profile interface
 *
 * @return HID boot host profile interface
 ****************************************************************************************
 */
const struct prf_task_cbs* hogpbh_prf_itf_get(void);

/**
 ****************************************************************************************
 * @brief Send HID ATT DB discovery results to HOGPBH host.
 ****************************************************************************************
 */
void hogpbh_enable_rsp_send(struct hogpbh_env_tag *hogpbh_env, uint8_t conidx, uint8_t status);


#endif /* (BLE_HID_BOOT_HOST) */

/// @} HOGPBH

#endif /* _HOGPBH_H_ */
