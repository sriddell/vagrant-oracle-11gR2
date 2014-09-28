default["oracle"]["db_packages"] = [
  "binutils",
  "compat-db",
  "compat-libstdc++-296",
  "compat-libstdc++-33",
  "compat-gcc-34",
  "compat-gcc-34-c++",
  "control-center",
  "elfutils-libelf",
  "elfutils-libelf-devel",
  "gcc",
  "gcc-c++",
  "glibc",
  "glibc-common",
  "glibc-devel",
  "glibc-headers",
  "ksh",
  "libaio",
  "libaio-devel",
  "libgcc",
  "libstdc++",
  "libstdc++-devel",
  "libXp",
  "libXt",
  "libXtst",
  "openmotif",
  "openmotif-devel",
  "make",
  "numactl-devel",
  "sysstat"
]

default["limits"] = [
    "oracle    soft    nproc   16384",
    "oracle    hard    nproc   16384",
    "oracle    soft    nofile  65536",
    "oracle    hard    nofile  65536",
    "oracle    soft    memlock 3145728",
    "oracle    hard    memlock 3145728"
]