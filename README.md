# FortranWAV

#### Table of contents
- [Install](#install)  
    - [Uninstall](#uninstall) 
- [Usage](#usage)  
    - [Disclaimer](#disclaimer)  
    - [Library] (#library)
- [Author](#author)  
- [License](#license)  

Basic Fortran module for reading .WAV file samples and metadata.

## Install
    If you want the defaults (library installed in /usr/local/lib/ and mod file in /usr/local/include/) just:  
```bash
    git clone https://github.com/SarKing/wavMF
    cd wavmf
    make
    sudo make install
``` 
    You can change the installation folder by editing the firsts lines of the Makefile  
#### Uninstall
    If you installed with the defaults just:  
    ```bash
       sudo make uninstall 
    ```
    Change the Makefile accordingly with your installation path.  

## Usage
#### Disclaimer
There is no error handling and it (natively) only works with 2-channel 16-bit .WAV files. 
This is one of my first attempts at coding with Fortran, so don't expect much.

#### Library 
If you installed the library (using the Makefile) you can compile your code indicating the path of the .mod file, i.e. (using
gfortran)  

```bash
    gfortran -c foo.f90 -I /usr/loca/include/
```
And the link indicanting the lib path  

```bash
    gfortran foo.o -L /usr/local/lib -lwavmf
```

Note tha you can also skip the installation and use the .mod and .o files located in the mod/ and /obj folder after compilation
with the Makedile.  
## Author
Raul Estevez Gomez. Contact email: estevezgomezraul@gmail.com  
Please feel free to contact me if you have any type of correction or question. 

## License
You can read the license [here](LICENSE)
