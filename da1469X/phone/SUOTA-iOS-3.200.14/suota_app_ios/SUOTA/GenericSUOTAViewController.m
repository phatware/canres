/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "GenericSUOTAViewController.h"

@interface GenericSUOTAViewController ()

@end

@implementation GenericSUOTAViewController

- (NSString*) getErrorMessage:(SPOTA_STATUS_VALUES)status {
    NSString *message;
    
    switch (status) {
        case SPOTAR_SRV_STARTED:
            message = @"Valid memory device has been configured by initiator. No sleep state while in this mode";
            break;
            
        case SPOTAR_CMP_OK:
            message = @"SPOTA process completed successfully.";
            break;
            
        case SPOTAR_SRV_EXIT:
            message = @"Forced exit of SPOTAR service.";
            break;
            
        case SPOTAR_CRC_ERR:
            message = @"Overall Patch Data CRC failed";
            break;
            
        case SPOTAR_PATCH_LEN_ERR:
            message = @"Received patch Length not equal to PATCH_LEN characteristic value";
            break;
            
        case SPOTAR_EXT_MEM_WRITE_ERR:
            message = @"External Mem Error (Writing to external device failed)";
            break;
            
        case SPOTAR_INT_MEM_ERR:
            message = @"Internal Mem Error (not enough space for Patch)";
            break;
            
        case SPOTAR_INVAL_MEM_TYPE:
            message = @"Invalid memory device";
            break;
            
        case SPOTAR_APP_ERROR:
            message = @"Application error";
            break;
            
            // SUOTAR application specific error codes
        case SPOTAR_IMG_STARTED:
            message = @"SPOTA started for downloading image (SUOTA application)";
            break;
            
        case SPOTAR_INVAL_IMG_BANK:
            message = @"Invalid image bank";
            break;
            
        case SPOTAR_INVAL_IMG_HDR:
            message = @"Invalid image header";
            break;
            
        case SPOTAR_INVAL_IMG_SIZE:
            message = @"Invalid image size";
            break;
            
        case SPOTAR_INVAL_PRODUCT_HDR:
            message = @"Invalid product header";
            break;
            
        case SPOTAR_SAME_IMG_ERR:
            message = @"Same Image Error";
            break;
            
        case SPOTAR_EXT_MEM_READ_ERR:
            message = @"Failed to read from external memory device";
            break;
            
        default:
            message = @"Unknown error";
            break;
    }
    
    return message;
}

@end
