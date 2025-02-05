#!/usr/bin/env python3

import subprocess
import sys

GO_OS_ARCH_LIST = [
    ["darwin" , "386"                  ],
    ["darwin" , "amd64"                ],
    ["darwin" , "amd64"   , "v3"       ],
    ["darwin" , "arm64"                ],
    ["darwin" , "arm"     , "7"        ],
    ["linux"  , "386"                  ],
    ["linux"  , "amd64"                ],
    ["linux"  , "amd64"   , "v3"       ],
    ["linux"  , "arm"     , "5"        ],
    ["linux"  , "arm"     , "6"        ],
    ["linux"  , "arm"     , "7"        ],
    ["linux"  , "arm64"                ],
    ["linux"  , "mips"    , "softfloat"],
    ["linux"  , "mips"    , "hardfloat"],
    ["linux"  , "mipsle"  , "softfloat"],
    ["linux"  , "mipsle"  , "hardfloat"],
    ["linux"  , "mips64"               ],
    ["linux"  , "mips64le"             ],
    ["freebsd", "386"                  ],
    ["freebsd", "amd64"                ],
    ["freebsd", "amd64"   , "v3"       ],
    ["windows", "386"                  ],
    ["windows", "amd64"                ],
    ["windows", "amd64"   , "v3"       ],
    ["windows", "arm"     , "7"        ],
    ["windows", "arm64"                ],
]

def go_build_desktop(binary_name, version, o, a, p):
    archflag = ""
    if a == "amd64":
        archflag = (" GOAMD64=" + (p[0] if p else "") if p else "")
    elif a == "arm":
        archflag = (" GOARM=" + (p[0] if p else "") if p else "")
    elif a == "mips":
        archflag = (" GOMIPS=" + (p[0] if p else "") if p else "")
    subprocess.check_call("GOOS=" + o + " GOARCH=" + a + archflag + " CGO_ENABLED=0" + " go build -ldflags \"-s -w " +
                                  "-X main.version=" + version + "\" -o " + binary_name + " main/main.go", shell=True)

def go_build_zip(arches, builder):
    subprocess.check_call("GOOS=windows go get -v github.com/travertexs/overture/main", shell=True)
    for o, a, *p in arches:
        zip_name = "overture-" + o + "-" + a + ("-" + (p[0] if p else "") if p else "")
        binary_name = zip_name + (".exe" if o == "windows" else "")
        #version = subprocess.check_output("git describe --tags", shell=True).decode()
        version = "v0.0.0-test"
        try:
            builder(binary_name, version, o, a, p)
            subprocess.check_call("zip " + zip_name + ".zip " + binary_name + " " + "hosts_sample "
                                                                                    "ip_network_primary_sample "
                                                                                    "ip_network_alternative_sample "
                                                                                    "domain_primary_sample "
                                                                                    "domain_alternative_sample "
                                                                                    "domain_ttl_sample "
                                                                                    "config.yml", shell=True)
        except subprocess.CalledProcessError:
            print(o + " " + a + " " + (p[0] if p else "") + " failed.")


def create_sample_file():
    with open("./hosts_sample", "w") as f:
        f.write("127.0.0.1 localhost")
    with open("./ip_network_primary_sample", "w") as f:
        f.write("127.0.0.9/32")
    with open("./ip_network_alternative_sample", "w") as f:
        f.write("127.0.0.10/32")
    with open("./domain_primary_sample", "w") as f:
        f.write("primary.example")
    with open("./domain_alternative_sample", "w") as f:
        f.write("alternative.example")
    with open("./domain_ttl_sample", "w") as f:
        f.write("ttl.example 1000")


if __name__ == "__main__":

    subprocess.check_call("cp config.sample.yml config.yml", shell=True)

    if "-create-sample" in sys.argv:
        create_sample_file()

    if "-build" in sys.argv:
        go_build_zip(GO_OS_ARCH_LIST, go_build_desktop)
