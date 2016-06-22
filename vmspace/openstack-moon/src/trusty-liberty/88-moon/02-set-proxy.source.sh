#!/bin/bash

sudo tee << EOF /etc/apt/apt.conf.d/20-proxy.conf
Acquire::http::Proxy "";
Acquire::https::Proxy "";
Acquire::ftp::Proxy "";
EOF

export http_proxy=""
export https_proxy=""

