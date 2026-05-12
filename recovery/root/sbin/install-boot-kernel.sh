#!/sbin/sh

if [ -f /sdcard/Fox/boot.img ]; then
rm -rf /data/thre
mkdir -p /data/thre
mkdir -p /data/thre/boot
mkdir -p /data/thre/recovery
MBOOT=/sbin/magiskboot
DEV=/dev/block/by-name
ThRE=/data/thre

dd if=$DEV/boot of=$ThRE/boot/boot.img
cp -f /sdcard/Fox/boot.img $ThRE/recovery/recovery.img
cp $MBOOT $ThRE/boot
cp $MBOOT $ThRE/recovery

cd $ThRE/recovery
./magiskboot unpack ./*.img

cd $ThRE/boot
./magiskboot unpack ./*.img
cp -rf ../recovery/kernel ./kernel
cp -rf ../recovery/kernel_dtb ./kernel
./magiskboot repack ./*.img ./kernel.img
dd if=$ThRE/boot/kernel.img of=$DEV/boot
rm -rf $ThRE
else
echo "what do you think?!"
echo "$1"
fi
exit
