image_file=/home/lei/app/test2/www/Dockerfile
image_file_md5=image_file_md5_package

image_file_md5_new=$(md5sum -b $image_file | awk '{print $1}'|sed 's/ //g')

function createdockerfilemd5() {
    sudo echo $image_file_md5_new > image_file_md5
}

function initcontainer(){
  docker run -p 10010:80 --name=test2 -v /home/lei/app/test2/www/:/user/local/apache2/htdocs/ -v /home/lei/app/test2/conf/httpd.conf:/usr/local/apache2/conf/httpd.conf -v /home/lei/app/test2/logs/:/usr/local/apache2/logs/ -v /root/anaconda3/envs/test2:/usr/local/anaconda -d ubuntu:hhhh
}

if [ ! -f $image_file_md5 ] ; then
  createdockerfilemd5
  docker build -t ubuntu:hhhh .
#  $image_name='ubuntu:hhhh'
  initcontainer
  exit
fi

image_file_md5_old=$(cat $image_file_md5|sed 's/ //g')
if [ "$image_file_md5_new" == "$image_file_md5_old" ] ; then
	docker run restart test2
else
	docker stop test2
	docker rm test2
	docker build -t ubuntu:dddd .
#	$image_name='ubuntu:dddd'
	initcontainer
fi