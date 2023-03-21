# mculib-controller-ch32v003

## Setup Notes

* Clone into `<project root>\Controller\CH32V003\` with `--recursive` tag
* Template files
  * Exclude `Template` folder from builds
  * Copy template files into parent `Controller` folder and modify to suit system needs
* Target Processor settings
  * Architecture: "`RV32E (-march=rv32e)`"
  * Compressed Extension (RVC) enabled
  * Integer ABI: "`ILP32E (-mabi=ilp32e)`"
  * others to disabled state (unchecked, "`None`" or "`Toolchain default`")
* GNU RISC-V Cross Assembler
  * Add include directory
    ```
    "${workspace_loc:/${ProjName}/Controller/CH32V003}"
    ```
  * Add include **files**
    ```
    "${workspace_loc:/${ProjName}/Controller/CH32V003/Core/custom_csr.s}"
    ```
* GNU RISC-V Cross C Compiler
  * Add include directories
    ```
    "${workspace_loc:/${ProjName}/Controller}"
    "${workspace_loc:/${ProjName}/Controller/CH32V003}"
    "${workspace_loc:/${ProjName}/Controller/CH32V003/Core}"
    "${workspace_loc:/${ProjName}/Controller/CH32V003/Peripheral/inc}"
    ```
* GNU RISC-V Cross C Linker
  * Set linkerscript location:
    ```
    "${workspace_loc:/${ProjName}/Controller/CH32V003/linker_script_ch32v003x4.ld}"
    ```
  * Select options:
    ```
    -nostartfiles
    -Xlinker --gc-sections
    --specs=nano.specs
    --specs=nosys.specs
    ```