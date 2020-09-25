cd /home/lei/app

if [ ! -d "/home/lei/app/test2/" ] ; then
  sudo mkdir test2 test2/conf test2/logs test2/www
  chmod -R 777 /home/lei/app/test2
  cd /home/lei/app/test2/www
else
  cd /home/lei/app/test2/www
fi

sudo docker cp jenkins-test:/var/jenkins_home/workspace/test2/. /home/lei/app/test2/www

bash ./init_env.sh
