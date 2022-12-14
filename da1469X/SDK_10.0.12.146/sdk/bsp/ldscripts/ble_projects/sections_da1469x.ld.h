/*
 * Copyright (C) 2014-2022 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 */
/* Linker script to place sections and symbol values. Should be used together
 * with other linker script that defines memory regions ROM and RAM.
 * It references following symbols, which must be defined in code:
 *   Reset_Handler : Entry of reset handler
 *
 * It defines following symbols, which code can use without definition:
 *   __exidx_start
 *   __exidx_end
 *   __copy_table_start__
 *   __copy_table_end__
 *   __zero_table_start__
 *   __zero_table_end__
 *   __etext
 *   __data_start__
 *   __preinit_array_start
 *   __preinit_array_end
 *   __init_array_start
 *   __init_array_end
 *   __fini_array_start
 *   __fini_array_end
 *   __data_end__
 *   __bss_start__
 *   __bss_end__
 *   __end__
 *   end
 *   __HeapBase
 *   __HeapLimit
 *   __StackLimit
 *   __StackTop
 *   __stack
 *   __Vectors_End
 *   __Vectors_Size
 */

/* Library configurations */
GROUP(libgcc.a libc.a libm.a libnosys.a)

#if (dg_configEXEC_MODE == MODE_IS_CACHED)
#define SNC_SECTION_SIZE                (__snc_section_end__ - __snc_section_start__)
#define RETENTION_RAM_INIT_SIZE         (__retention_ram_init_end__ - __retention_ram_init_start__)
#define NON_RETENTION_RAM_INIT_SIZE     (__non_retention_ram_init_end__ - __non_retention_ram_init_start__)
#else
/* CODE and RAM are merged into a single RAM section */
#define ROM                             RAM
#endif

#if ( dg_configUSE_SEGGER_FLASH_LOADER == 1 )

#define QSPI_FLASH_ADDRESS 0x16000000
#define QSPI_FW_BASE_OFFSET 0x2000
#define QSPI_FW_IVT_OFFSET  0x400
#define QSPI_FW_BASE_ADDRESS (QSPI_FLASH_ADDRESS + QSPI_FW_BASE_OFFSET)
#define QSPI_FW_IVT_BASE_ADDRESS (QSPI_FW_BASE_ADDRESS + QSPI_FW_IVT_OFFSET)
#else
#define QSPI_FW_IVT_BASE_ADDRESS 0x0
#endif /* dg_configUSE_SEGGER_FLASH_LOADER */

ENTRY(Reset_Handler)

SECTIONS
{
        .init_text :
#if ( dg_configUSE_SEGGER_FLASH_LOADER == 1 )
        AT ( QSPI_FW_IVT_BASE_ADDRESS)
#endif /* dg_configUSE_SEGGER_FLASH_LOADER */
        {
                KEEP(*(.isr_vector))
                /* Interrupt vector remmaping overhead */
                . = 0x200;
                __Vectors_End = .;
                __Vectors_Size = __Vectors_End - __isr_vector;
                *(text_reset*)
        } > ROM

        .text :
        {
                /* Optimize the code of specific libgcc files by executing them
                 * from the .retention_ram_init section. */
                *(EXCLUDE_FILE(*libnosys.a:sbrk.o
                               *libgcc.a:_aeabi_uldivmod.o
                               *libgcc.a:_muldi3.o
                               *libgcc.a:_dvmd_tls.o
                               *libgcc.a:bpabi.o
                               *libgcc.a:_udivdi3.o
                               *libgcc.a:_clzdi2.o
                               *libgcc.a:_clzsi2.o) .text*)

                . = ALIGN(4);

#ifdef CONFIG_USE_BLE
#if (dg_configEXEC_MODE != MODE_IS_CACHED)
                . = ALIGN(0x400); /* Code region should start at 1Kb boundary */

                cmi_fw_dst_addr = .;
#endif

                /*
                 * Section used to store the CMAC FW.
                 * Code should copy this FW to address 'cmi_fw_dst_addr' and
                 * configure the memory controller accordingly.
                 */
                __cmi_fw_area_start = .;
                KEEP(*(.cmi_fw_area*))
                __cmi_fw_area_end = .;

#if (dg_configEXEC_MODE != MODE_IS_CACHED)
                . = ALIGN(4); /* Data region should start at 4-bytes boundary */

                /*
                 * Create space for CMAC data
                 */
                KEEP(*(.cmi_data_area*))

                . = ALIGN(0x400); /* End region should end at 1Kb boundary */

                __cmi_section_end__ = . - 1;
#endif
#endif /* CONFIG_USE_BLE */
                . = ALIGN(4);
                __start_adapter_init_section = .;
                KEEP(*(adapter_init_section))
                __stop_adapter_init_section = .;

                . = ALIGN(4);
                __start_bus_init_section = .;
                KEEP(*(bus_init_section))
                __stop_bus_init_section = .;

                . = ALIGN(4);
                __start_device_init_section = .;
                KEEP(*(device_init_section))
                __stop_device_init_section = .;

                KEEP(*(.init))
                KEEP(*(.fini))

                /* .ctors */
                *crtbegin.o(.ctors)
                *crtbegin?.o(.ctors)
                *(EXCLUDE_FILE(*crtend?.o *crtend.o) .ctors)
                *(SORT(.ctors.*))
                *(.ctors)

                /* .dtors */
                *crtbegin.o(.dtors)
                *crtbegin?.o(.dtors)
                *(EXCLUDE_FILE(*crtend?.o *crtend.o) .dtors)
                *(SORT(.dtors.*))
                *(.dtors)

                . = ALIGN(4);
                /* preinit data */
                PROVIDE_HIDDEN (__preinit_array_start = .);
                KEEP(*(.preinit_array))
                PROVIDE_HIDDEN (__preinit_array_end = .);

                . = ALIGN(4);
                /* init data */
                PROVIDE_HIDDEN (__init_array_start = .);
                KEEP(*(SORT(.init_array.*)))
                KEEP(*(.init_array))
                PROVIDE_HIDDEN (__init_array_end = .);

                . = ALIGN(4);
                /* finit data */
                PROVIDE_HIDDEN (__fini_array_start = .);
                KEEP(*(SORT(.fini_array.*)))
                KEEP(*(.fini_array))
                PROVIDE_HIDDEN (__fini_array_end = .);

                *(.rodata*)

                KEEP(*(.eh_frame*))
        } > ROM

        .ARM.extab :
        {
                *(.ARM.extab* .gnu.linkonce.armextab.*)
        } > ROM

        __exidx_start = .;
        .ARM.exidx :
        {
                *(.ARM.exidx* .gnu.linkonce.armexidx.*)
        } > ROM
        __exidx_end = .;

        /* To copy multiple ROM to RAM sections,
         * uncomment .copy.table section and,
         * define __STARTUP_COPY_MULTIPLE in startup_ARMCMx.S */

        .copy.table :
        {
                . = ALIGN(4);
                __copy_table_start__ = .;
#if (dg_configEXEC_MODE == MODE_IS_CACHED)
                LONG (__etext)
                LONG (__retention_ram_init_start__)
                LONG (RETENTION_RAM_INIT_SIZE)

                LONG (__etext + (RETENTION_RAM_INIT_SIZE))
                LONG (__snc_section_start__)
                LONG (SNC_SECTION_SIZE)

                LONG (__etext + (RETENTION_RAM_INIT_SIZE) + (SNC_SECTION_SIZE))
                LONG (__non_retention_ram_init_start__)
                LONG (NON_RETENTION_RAM_INIT_SIZE)
#endif
                __copy_table_end__ = .;
        } > ROM


        /* To clear multiple BSS sections,
         * uncomment .zero.table section and,
         * define __STARTUP_CLEAR_BSS_MULTIPLE in startup_ARMCMx.S */

        .zero.table :
        {
                . = ALIGN(4);
                __zero_table_start__ = .;
                LONG (__bss_start__)
                LONG (__bss_end__ - __bss_start__)
                LONG (__retention_ram_zi_start__)
                LONG (__retention_ram_zi_end__ - __retention_ram_zi_start__)
                __zero_table_end__ = .;
        } > ROM

        __etext = .;

        /*
        * Retention ram that should not be initialized during startup.
        * On QSPI cached images, it should be at a fixed RAM address for both
        * the bootloader and the application, so that the bootloader will not alter
        * those data due to conflicts between its .data/.bss sections with application's
        * .retention_ram_uninit section.
        * - On QSPI images it is relocated to the first RAM address after IVT_AREA_OVERHEAD
        *       with fixed size of dg_configRETAINED_UNINIT_SECTION_SIZE bytes.
        * - On RAM images the section is not located at a fixed location.
        */
        .retention_ram_uninit (NOLOAD) :
        {
                __retention_ram_uninit_start__ = .;
#if (dg_configEXEC_MODE == MODE_IS_CACHED)
                ASSERT( . == ORIGIN(RAM), ".retention_ram_uninit section moved!");
#endif /* (dg_configEXEC_MODE == MODE_IS_CACHED) */
                KEEP(*(nmi_info))
                KEEP(*(hard_fault_info))
                KEEP(*(retention_mem_uninit))

                ASSERT( . <= __retention_ram_uninit_start__ + dg_configRETAINED_UNINIT_SECTION_SIZE,
                        "retention_ram_uninit section overflowed! Increase dg_configRETAINED_UNINIT_SECTION_SIZE.");

                . = __retention_ram_uninit_start__ + dg_configRETAINED_UNINIT_SECTION_SIZE;
                __retention_ram_uninit_end__ = .;
        } > RAM

        /*
         * Initialized retention RAM
         */
#if (dg_configEXEC_MODE == MODE_IS_CACHED)
        .retention_ram_init : AT (QSPI_FW_IVT_BASE_ADDRESS +__etext)
#else
        /*
         * No need to add this to the copy table,
         * copy will be done by the debugger.
         */
        .retention_ram_init :
#endif
        {
                __retention_ram_init_start__ = .;
                . = ALIGN(4); /* Required by copy table */

                /*
                 * Retained .text sections moved to RAM that need to be initialized
                 */
#if (dg_configEXEC_MODE == MODE_IS_CACHED)
                /* Retained code exists only in QSPI projects */
                *(text_retained)
#endif
                /* Make the '.text' section of specific libgcc files retained, to
                 * optimize perfomance */
                *libnosys.a:sbrk.o (.text*)
                *libgcc.a:_aeabi_uldivmod.o (.text*)
                *libgcc.a:_muldi3.o (.text*)
                *libgcc.a:_dvmd_tls.o (.text*)
                *libgcc.a:bpabi.o (.text*)
                *libgcc.a:_udivdi3.o (.text*)
                *libgcc.a:_clzdi2.o (.text*)
                *libgcc.a:_clzsi2.o (.text*)

                /*
                 * Retained .data sections that need to be initialized
                 */

                /* Retained data */
                *(privileged_data_init)
                *(.retention)

                *(vtable)

                *(retention_mem_init)
                *(retention_mem_const)

                *libg_nano.a:* (.data*)
                *libnosys.a:* (.data*)
                *libgcc.a:* (.data*)
                *libble_stack_da1469x.a:* (.data*)
                *crtbegin.o (.data*)

                KEEP(*(.jcr*))
                . = ALIGN(4); /* Required by copy table */
                /* All data end */
                __retention_ram_init_end__ = .;
        } > RAM

        /*
         * Zero-initialized retention RAM
         */
        .retention_ram_zi (NOLOAD) :
        {
                __retention_ram_zi_start__ = .;

                *(privileged_data_zi)
                *(retention_mem_zi)

                *libg_nano.a:* (.bss*)
                *libnosys.a:* (.bss*)
                *libgcc.a:* (.bss*)
                *libble_stack_da1469x.a:* (.bss*)
                *crtbegin.o (.bss*)

                *(os_heap)

                __HeapBase = .;
                __end__ = .;
                end = __end__;
                KEEP(*(.heap*))
                __HeapLimit = .;

                __retention_ram_zi_end__ = .;
        } > RAM

        .stack_section (NOLOAD) :
        {
                /* Advance the address to avoid output section discarding */
                . = . + 1;
                /* 8-byte alignment guaranteed by vector_table_da1469x.S, also put here for
                 * clarity. */
                . = ALIGN(8);
                __StackLimit = .;
                KEEP(*(.stack*))
                . = ALIGN(8);
                __StackTop = .;
                /* Provide __StackTop to newlib by defining __stack externally. SP will be
                 * set when executing __START. If not provided, SP will be set to the default
                 * newlib nano value (0x80000) */
                PROVIDE(__stack = __StackTop);
        } > RAM

        /*
         * Sensor node controller section, used for SNC code and possibly for SNC data.
         */
#if (dg_configEXEC_MODE == MODE_IS_CACHED)
        .snc_section : AT (QSPI_FW_IVT_BASE_ADDRESS + __etext + (RETENTION_RAM_INIT_SIZE))
#else
        /*
         * No need to add this to the copy table,
         * copy will be done by the debugger.
         */
        .snc_section :
#endif
        {
                __snc_section_start__ = .;
                . = ALIGN(4); /* Required by copy table */
                KEEP(*(.snc_region*))
                . = ALIGN(4); /* Required by copy table */
                __snc_section_end__ = .;
        } > RAM

#ifdef CONFIG_USE_BLE
#if (dg_configEXEC_MODE == MODE_IS_CACHED)
        /*
         * CMAC interface section
         */
        .cmi_section (NOLOAD) :
        {
                __cmi_section_start__ = .;

                . = ALIGN(0x400); /* Code region should start at 1Kb boundary */

                /*
                 * The actual CMAC code (copied from '.cmi_fw_area')
                 * will be running here.
                 */
                cmi_fw_dst_addr = .;

                /*
                 * Create space to copy/expand the CMAC image to.
                 */
                . += (__cmi_fw_area_end - __cmi_fw_area_start);

                . = ALIGN(4); /* Data region should start at 4-bytes boundary */

                /*
                 * Create space for CMAC data
                 */
                KEEP(*(.cmi_data_area*))

                . = ALIGN(0x400); /* End region should end at 1Kb boundary */

                __cmi_section_end__ = . - 1;
        } > RAM
#endif /* (dg_configEXEC_MODE == MODE_IS_CACHED) */
#endif /* CONFIG_USE_BLE */

        __non_retention_ram_start__ = .;

        /*
         * Initialized RAM area that does not need to be retained during sleep.
         * On RAM projects, they are located in the .retention_ram_init section
         * for better memory handling.
         */
#if (dg_configEXEC_MODE == MODE_IS_CACHED)
        .non_retention_ram_init :  AT (QSPI_FW_IVT_BASE_ADDRESS + __etext + (RETENTION_RAM_INIT_SIZE) + (SNC_SECTION_SIZE))
#else
        /*
         * No need to add this to the copy table,
         * copy will be done by the debugger.
         */
        .non_retention_ram_init :
#endif
        {
                __non_retention_ram_init_start__ = .;
                . = ALIGN(4); /* Required by copy table */
                *(EXCLUDE_FILE(*libg_nano.a:* *libnosys.a:* *libgcc.a:* *libble_stack_da1469x.a:* *crtbegin.o) .data*)

                . = ALIGN(4); /* Required by copy table */
                __non_retention_ram_init_end__ = .;
        } > RAM

        /*
         * Note that region [__bss_start__, __bss_end__] will be also zeroed by newlib nano,
         * during execution of __START.
         */
        .bss :
        {
                . = ALIGN(4);
                __bss_start__ = .;

                *(EXCLUDE_FILE(*libg_nano.a:* *libnosys.a:* *libgcc.a:* *libble_stack_da1469x.a:* *crtbegin.o) .bss*)

                *(COMMON)
                . = ALIGN(4);
                __bss_end__ = .;
        } > RAM

        __non_retention_ram_end__ = .;

        __unused_ram_start__ = . + 1;

#if ( dg_configUSE_SEGGER_FLASH_LOADER == 1 )
        .prod_head :
        AT ( QSPI_FLASH_ADDRESS)
        SUBALIGN(1)
        {
                SHORT(0x7050)                   // 'Pp' flag
                LONG(QSPI_FW_BASE_OFFSET)       // active image pointer
                LONG(QSPI_FW_BASE_OFFSET)       // update image pointer
                KEEP(*(__product_header_primary__))
                . = 0X1000;
        } > ROM = 0xFFFFFFFF

        .prod_head_backup :
        AT ( QSPI_FLASH_ADDRESS + 0x1000)
        SUBALIGN(1)
        {
                SHORT(0x7050)                   // 'Pp' flag
                LONG(QSPI_FW_BASE_OFFSET)       // active image pointer
                LONG(QSPI_FW_BASE_OFFSET)       // update image pointer
                KEEP(*(__product_header_backup__))
                . = (QSPI_FW_BASE_OFFSET - 0x1000);
        } > ROM = 0xFFFFFFFF

        .img_head :
        AT (QSPI_FW_BASE_ADDRESS)
        {
                SHORT(0x7151)                   // 'Pp' flag
                LONG(SIZEOF(.text))             // size
                LONG(0x0)                       // crc, doesn't matter
                LONG(0x0)                       // version, doesn't matter
                LONG(0x0)                       // version, doesn't matter
                LONG(0x0)                       // version, doesn't matter
                LONG(0x0)                       // version, doesn't matter
                LONG(0x0)                       // timestamp, doesn't matter
                LONG(QSPI_FW_IVT_OFFSET)        // IVT pointer
                SHORT(0x22AA)                   // Security section type
                SHORT(0x0)                      // Security section length
                SHORT(0x44AA)                   // Device admin type
                SHORT(0x0)                      // Device admin length
                . = QSPI_FW_IVT_OFFSET;
        } > ROM = 0xFFFFFFFF
#endif /* dg_configUSE_SEGGER_FLASH_LOADER */

#if (dg_configEXEC_MODE == MODE_IS_CACHED)
        /* Make sure that the initialized data fits in flash */
        ASSERT(__etext + RETENTION_RAM_INIT_SIZE + SNC_SECTION_SIZE + NON_RETENTION_RAM_INIT_SIZE <
                        ORIGIN(ROM) + dg_configQSPI_MAX_IMAGE_SIZE, "ROM space overflowed")
#endif
}
