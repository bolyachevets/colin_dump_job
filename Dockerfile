FROM python:3.8.5-buster

USER root

# Installing Oracle instant client
WORKDIR /opt/oracle
RUN apt-get update && apt-get install -y libaio1 gdb wget unzip \
    && wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip \
    && wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-sqlplus-linux.x64-21.1.0.0.0.zip \
    && unzip instantclient-basiclite-linux.x64-21.1.0.0.0.zip \
    && rm -f instantclient-basiclite-linux.x64-21.1.0.0.0.zip \
    && unzip instantclient-sqlplus-linux.x64-21.1.0.0.0.zip \
    && rm -f instantclient-sqlplus-linux.x64-21.1.0.0.0.zip \
    && cd /opt/oracle/instantclient* \
    && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
    && echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig

# Create working directory
RUN mkdir /opt/app-root && chmod 755 /opt/app-root
WORKDIR /opt/app-root

# Install the requirements
COPY ./requirements.txt .

RUN pip install pip==20.1.1
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Set Python path
ENV PYTHONPATH=/opt/app-root

EXPOSE 8080

CMD [ "/bin/sh", "run.sh" ]
