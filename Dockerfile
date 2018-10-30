FROM store/oracle/database-instantclient:12.2.0.1

# Install Python 3.6 on Oracle Linux 7
# Ref: https://yum.oracle.com/oracle-linux-python.html#InstallFromEPEL
RUN yum update -y && \
    yum install -y yum-utils wget curl

# Get Python 3
WORKDIR /etc/yum.repos.d
RUN mv public-yum-ol7.repo public-yum-ol7.repo.bak && \
    wget http://yum.oracle.com/public-yum-ol7.repo && \
    yum-config-manager --enable ol7_developer_EPEL && \
    yum install -y python36 && \
    yum clean -y all

# Get Pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.6 get-pip.py && \
    rm -rf get-pip.py

# Install Python Packages
RUN python3.6 -m pip install pandas sqlalchemy cx_oracle

CMD ["python3.6"]
