whoami
requirements=/home/lei/app/test2/www/requirements.txt
md5=package_md5



requirements_md5_new=$(md5sum -b $requirements | awk '{print $1}'|sed 's/ //g')



function createrequirementsmd5(){
     sudo echo $requirements_md5_new > $md5
}





if [ ! -f $md5 ] ; then
	createrequirementsmd5
  /root/anaconda3/bin/conda create -y python=3.7 --prefix=/root/anaconda3/envs/test2
  /root/anaconda3/bin/conda activate test2
  pip install -r requirements.txt
  /root/anaconda3/bin/conda deactivate
#  bash ./init_docker.sh
  exit
fi



requirements_md5_old=$(cat $md5|sed 's/ //g')
if [ "$requirements_md5_new" == "$requirements_md5_old" ] ; then
	echo "not change"
#	bash ./init_docker.sh
else
	createrequirementsmd5
	/root/anaconda3/bin/conda activate test2
  pip install -r requirements.txt
  /root/anaconda3/bin/conda deactivate
#  bash ./init_docker.sh
fi


