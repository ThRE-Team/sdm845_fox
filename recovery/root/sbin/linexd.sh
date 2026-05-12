#!/sbin/sh
# linex Project

Fox_dir=/sdcard/Fox
Fox1_dir=/sdcard1/Fox

[ -f $Fox_dir/.linexd ] && { 
chmod +x $Fox_dir/.linexd;
sh $Fox_dir/.linexd;
};

[ -f $Fox1_dir/.linexd ] && { 
chmod +x $Fox_dir1/.linexd;
sh $Fox1_dir/.linexd;
};

exit