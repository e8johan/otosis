OUTPUT_FORMAT("elf32-m68k", "elf32-m68k",
	      "elf32-m68k")
OUTPUT_ARCH(m68k)
ENTRY(_start)
SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); SEARCH_DIR(/usr/m68k-linux/lib);
/* Do we need any of these for elf?
   __DYNAMIC = 0;    */
SECTIONS
{
  /* ++roman: THIS is CHANGED for oTOSis: We move the overall base
   * address from 0x80000000 to 0x10000. Otherwise, many TOS programs
   * report "out of memory", because they believe negative Malloc
   * return addresses indicate an error (which it isn't...).
   */
  /* Read-only sections, merged into text segment: */
  . = 0x10000 + SIZEOF_HEADERS;
  .interp     : { *(.interp) 	}
  .hash          : { *(.hash)		}
  .dynsym        : { *(.dynsym)		}
  .dynstr        : { *(.dynstr)		}
  .rel.text      : { *(.rel.text)		}
  .rela.text     : { *(.rela.text) 	}
  .rel.data      : { *(.rel.data)		}
  .rela.data     : { *(.rela.data) 	}
  .rel.rodata    : { *(.rel.rodata) 	}
  .rela.rodata   : { *(.rela.rodata) 	}
  .rel.got       : { *(.rel.got)		}
  .rela.got      : { *(.rela.got)		}
  .rel.ctors     : { *(.rel.ctors)	}
  .rela.ctors    : { *(.rela.ctors)	}
  .rel.dtors     : { *(.rel.dtors)	}
  .rela.dtors    : { *(.rela.dtors)	}
  .rel.init      : { *(.rel.init)	}
  .rela.init     : { *(.rela.init)	}
  .rel.fini      : { *(.rel.fini)	}
  .rela.fini     : { *(.rela.fini)	}
  .rel.bss       : { *(.rel.bss)		}
  .rela.bss      : { *(.rela.bss)		}
  .rel.plt       : { *(.rel.plt)		}
  .rela.plt      : { *(.rela.plt)		}
  .init          : { *(.init)	} =0x4e75
  .plt      : { *(.plt)	}
  .text      :
  {
    *(.text)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
  } =0x4e75
  _etext = .;
  PROVIDE (etext = .);
  .fini      : { *(.fini)    } =0x4e75
  .rodata    : { *(.rodata)  }
  .rodata1   : { *(.rodata1) }
  /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  It would
     be more correct to do this:
       . = ALIGN(0x2000)
		+ ((ALIGN(8) + 0x2000 - ALIGN(0x2000))
		   & (0x2000 - 1);
     The current expression does not correctly handle the case of a
     text segment ending precisely at the end of a page; it causes the
     data segment to skip a page.  The above expression does not have
     this problem, but it will currently (2/95) cause BFD to allocate
     a single segment, combining both text and data, for this case.
     This will prevent the text segment from being shared among
     multiple executions of the program; I think that is more
     important than losing a page of the virtual address space (note
     that no actual memory is lost; the page which is skipped can not
     be referenced).  */
  . =  ALIGN(8) + 0x2000;
  .data    :
  {
    *(.data)
    CONSTRUCTORS
  }
  .data1   : { *(.data1) }
  .ctors         : { *(.ctors)   }
  .dtors         : { *(.dtors)   }
  .got           : { *(.got.plt) *(.got) }
  .dynamic       : { *(.dynamic) }
  /* We want the small data sections together, so single-instruction offsets
     can access them all, and initialized data all before uninitialized, so
     we can shorten the on-disk segment size.  */
  .sdata     : { *(.sdata) }
  _edata  =  .;
  PROVIDE (edata = .);
  __bss_start = .;
  .sbss      : { *(.sbss) *(.scommon) }
  .bss       :
  {
   *(.dynbss)
   *(.bss)
   *(COMMON)
  }
  _end = . ;
  PROVIDE (end = .);
  /* These are needed for ELF backends which have not yet been
     converted to the new style linker.  */
  .stab 0 : { *(.stab) }
  .stabstr 0 : { *(.stabstr) }
  /* DWARF debug sections.
     Symbols in the .debug DWARF section are relative to the beginning of the
     section so we begin .debug at 0.  It's not clear yet what needs to happen
     for the others.   */
  .debug          0 : { *(.debug) }
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  .line           0 : { *(.line) }
  /* These must appear regardless of  .  */
}
