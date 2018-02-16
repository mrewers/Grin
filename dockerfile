FROM Debian:

# Create swapfile
RUN sudo dd if=/dev/zero of=/swapfile bs=1M count=2048
RUN sudo mkswap /swapfile
RUN sudo swapon /swapfile
RUN sudo chmod 600 /swapfile

# Download dependencies
RUN sudo apt-get install -y g++ \
    git-core \
    clang \
    make \

# Compile Cmake
RUN wget https://cmake.org/files/v3.10/cmake-3.10.2.tar.gz | tar xzf cmake-3.10.2.tar.gz
RUN rm cmake-3.10.2.tar.gz

RUN cd cmake-3.10.2
RUN ./configure
RUN make
RUN sudo make install

# Install Rustc
RUN curl https://sh.rustup.rs -sSf | sh
RUN source $HOME/.cargo/env

# Install Grin
RUN git clone https://github.com/mimblewimble/grin.git
RUN git checkout milestone/testnet1
RUN cargo build

RUN export PATH=`pwd`/target/debug:$PATH
RUN cd wallet
RUN grin wallet init
