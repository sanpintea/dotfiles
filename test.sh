if [ `hostname` = "mypc" ]; then
		msys=`env | grep MSYSTEM=` 
	if [ "${msys}" = "MSYSTEM=MSYS" ]; then
		echo "msys"
	elif [ "${msys}" =  MSYSTEM=MINGW32 ]; then
		echo "mingw32"
	else
		echo "cygwin"	
	fi
fi

	
# msys=`env | grep MSYSTEM=`
# if [ "${msys}" = "MSYSTEM=MSYS" ] ; then
# echo $msys
# fi
