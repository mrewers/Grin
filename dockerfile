FROM Debian:

# Download dependencies
RUN sudo apt-get install g++ \
    make \

# Compile Cmake
RUN wget https://cmake.org/files/v3.10/cmake-3.10.2.tar.gz | tar xzf cmake-3.10.2.tar.gz

RUN cd cmake-3.10.2
RUN ./configure
RUN make

# Install Grin
RUN git clone https://github.com/mimblewimble/grin.git
RUN git checkout milestone/testnet1
RUN cargo build

---
RUN curl https://sh.rustup.rs -sSf | sh; source $HOME/.cargo/env
