/**
 ****************************************************************************************
 *
 * @file ExternalResources.c
 *
 * @brief External resources support source file
 *
 * Copyright (C) 2019 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 ****************************************************************************************
 */
#include "GUI.h"
#include "ExternalResources.h"
#include "osal.h"

/*
 * Open a specific flash partition
 */
hPartition_t _OpenPartition(int PartitionID)
{
       return ad_nvms_open(PartitionID);
}

/*
 * Callback function used to retrieve font information stored in flash in XBF format.
 */
static int _cbGetXBFData(U32 Off, U16 NumBytes, void * pVoid, void * pBuffer)
{
        USERDATA_EXTERNAL_RESOURCES * UserData;
        int NumReadBytes;

        UserData = (USERDATA_EXTERNAL_RESOURCES *)pVoid;
        NumReadBytes = ad_nvms_read(UserData->hPartition, (uint32_t)Off + UserData->Offset, (uint8_t *)pBuffer, (uint32_t)NumBytes);
        if (NumReadBytes != NumBytes) {
                return 1; // Error
        }
        return 0; // OK
}

/*
 * Create a font stored in flash in XBF format.
 */
int _XBFCreateFont(GUI_FONT ** pFont, GUI_XBF_DATA ** pXBF, const GUI_XBF_TYPE * pFontType, void * pData)
{
        GUI_FONT * pFontData;     // Filled by the XBF mechanism
        GUI_XBF_DATA * pXBFData;  // Filled by the XBF mechanism
        int status;
        USERDATA_EXTERNAL_RESOURCES * UserData;

        UserData = (USERDATA_EXTERNAL_RESOURCES *)pData;
        UserData->hPartition = _OpenPartition(UserData->PartitionID);

        if (UserData->hPartition != NULL) {
                pFontData = (GUI_FONT *)OS_MALLOC(sizeof(GUI_FONT));
                pXBFData  = (GUI_XBF_DATA *)OS_MALLOC(sizeof(GUI_XBF_DATA));
                // Check if all resources are allocated successfully
                if (pFontData && pXBFData) {
                        // Create a new XBF font type.
                        status = GUI_XBF_CreateFont(pFontData, pXBFData, pFontType, _cbGetXBFData, UserData);
                        if (status == XBF_STATUS_SUCCESS) {
                                // If everything is OK, return the pointers back to the user
                                if ( pFont ) *pFont = pFontData;
                                if ( pXBF ) *pXBF = pXBFData;
                        }
                        // Otherwise, free the already allocated memory area
                        else if (status == XBF_STATUS_FAIL) {
                                OS_FREE(pFontData);
                                OS_FREE(pXBFData);
                        }
                        return status;
                }
                // Release the resources if at least one resource cannot be allocated
                else {
                        if (pFontData) OS_FREE(pFontData);
                        if (pXBFData) OS_FREE(pXBFData);
                }
                return XBF_STATUS_MALLOC_FAIL; // Memory allocation failed
        }
        return XBF_STATUS_PARTITION_FAIL;  // Flash partition failed to open
}

/*
 * Delete a font and release all its resources allocated at creation.
 */
void _XBFDeleteFont(GUI_FONT * pFont, GUI_XBF_DATA * pXBF)
{
        // Release the already acquired resources
        if (pFont) {
                GUI_XBF_DeleteFont(pFont);
                OS_FREE(pFont);
        }
        if (pXBF) OS_FREE(pXBF);
}

/*
 * User-defined callback function used by emWin to retrieve bitmap stream data stored in flash.
 */
int _cbGetBitmapStreamData(void * p, const U8 ** ppData, unsigned NumBytes, U32 Off) {
        int NumReadBytes;
        U8 * pData;
        USERDATA_EXTERNAL_RESOURCES * UserData;

        pData = (U8 *)*ppData;
        NumReadBytes = 0;
        UserData = (USERDATA_EXTERNAL_RESOURCES *)p;

        UserData->hPartition = _OpenPartition(UserData->PartitionID);

        // First check if the provided partition is valid
        if (UserData->hPartition != NULL) {
              NumReadBytes = ad_nvms_read(UserData->hPartition, (uint32_t)Off + UserData->Offset, (uint8_t *)pData, (uint32_t)NumBytes);
        }
        return NumReadBytes; // The routine should return the number of read data
}
