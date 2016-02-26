host=`hostname`
if  [ ${host} = "ubuntu" ] 
then
		export TEST="ubuntu"
elif [ `hostname` = "mypc" ]
then
		export TEST="mypc"
else
		export TEST="none"
fi

