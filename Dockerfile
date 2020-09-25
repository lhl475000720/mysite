FROM ubuntu:v1
RUN echo '这是一个测试文件' > /usr/share/text.txt
RUN apt-get update
RUN apt-get install weget