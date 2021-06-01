## Step1: Download Modelsim

## Install LIB32 packge and build 
Download Freetype
```
https://download-mirror.savannah.gnu.org/releases/freetype/
```
Build:
```
cd freetype-2.4.12
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
make -j8
```
COPY LIB to MODELSIM LIB32
```
mkdir $MODELSIM_INSTALL_DIR/lib32

sudo cp freetype-2.4.12/objs/.libs/libfreetype.so* $MODELSIM_INSTALL_DIR/lib32
```
Config PATH
add to ~/.bashrc
```
export MODELSIM_INSTALL_DIR=~/altera/13.1/modelsim_ase/
export PATH=$PATH:$MODELSIM_INSTALL_DIR/bin
export LD_LIBRARY_PATH=$MODELSIM_INSTALL_DIR/lib32

```
```
source  ~/.bashrc
```
## Step 3 Fix ERRORS

Ref this LINK: https://gist.github.com/PrieureDeSion/e2c0945cc78006b00d4206846bdb7657
```
Error: cannot find /home/ryan/altera/13.1/modelsim_ase/bin/../linux_rh60/vsim
```

```
```