FROM quay.io/pypa/manylinux_2_28_x86_64 AS build_stage

# Install python 3.8 and deps
RUN yum install -y python38-devel
RUN ln -fs /usr/local/bin/pip3.8 /usr/bin/pip && \
    ln -fs /usr/local/bin/python3.8 /usr/bin/python

# get source and save aws version
RUN curl https://awscli.amazonaws.com/awscli.tar.gz -o awscli.tar.gz
RUN tar xvf awscli.tar.gz
RUN echo -n "$(ls / | grep awscli-)" >> .aws_version
RUN mv awscli-* awscli

# build single executable
WORKDIR /awscli
COPY ./aws.spec ./exe/pyinstaller/aws.spec
RUN ./configure --with-install-type=portable-exe --with-download-deps
RUN make || true
RUN find . -name aws
RUN test -f ./build/exe/dist/aws
RUN mv ./build/exe/dist/aws $(cat /.aws_version)

# export executable
FROM scratch AS export_stage
COPY --from=build_stage /awscli/awscli-* /
