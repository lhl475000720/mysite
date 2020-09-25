
requirements=/home/lei/app/test2/www/requirements.txt
md5=package_md5

image_file=/home/lei/app/test2/www/Dockerfile
image_file_md5=image_file_md5_package

requirements_md5_new=$(md5sum -b $requirements | awk '{print $1}'|sed 's/ //g')
image_file_md5_new=$(md5sum -b $image_file | awk '{print $1}'|sed 's/ //g')


function createrequirementsmd5(){
     sudo echo $requirements_md5_new > $md5
}

function createdockerfilemd5() {
    sudo echo $image_file_md5_new > image_file_md5
}

function initcontainer(){
  docker run -p 10010:80 --name=test2 -v /home/lei/app/test2/www/:/user/local/apache2/htdocs/ -v /home/lei/app/test2/conf/httpd.conf:/usr/local/apache2/conf/httpd.conf -v /home/lei/app/test2/logs/:/usr/local/apache2/logs/ -v /root/anaconda3/envs/test2:/usr/local/anaconda -d ubuntu:hhhh
}

if [ ! -f $md5 ] ; then
	createrequirementsmd5
  conda create -y python=3.7 --prefix=/root/anaconda3/envs/test2
  conda activate test2
  pip install -r requirements.txt
  conda deactivate
fi

if [ ! -f $image_file_md5 ] ; then
  createdockerfilemd5
  docker build -t ubuntu:hhhh .
#  $image_name='ubuntu:hhhh'
  initcontainer
fi

requirements_md5_old=$(cat $md5|sed 's/ //g')
if [ "$requirements_md5_new" == "$requirements_md5_old" ] ; then
	echo "not change"
else
	createrequirementsmd5
	conda activate test2
  pip install -r requirements.txt
  conda deactivate
fi


image_file_md5_old=$(cat $md5|sed 's/ //g')
if [ "$image_file_md5_new" == "$image_file_md5_old" ] ; then
	docker restart test2
else
	docker stop test2
	docker rm test2
	docker build -t ubuntu:dddd .
#	$image_name='ubuntu:dddd'
	initcontainer
fi