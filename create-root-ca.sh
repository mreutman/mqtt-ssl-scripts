#!/bin/sh

BASE=$(realpath $(dirname $0))

if [ ! -f $BASE/subj.conf ]; then
  echo "File $BASE/subj.conf not found!"
  exit 1
fi

# Import settings.
. $BASE/subj.conf

C=$ROOT_C
ST=$ROOT_ST
L=$ROOT_L
O=$ROOT_O
OU=$ROOT_OU
CN=$ROOT_CN

SUBJ="/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN"
OUT_DIR="$BASE/root"

mkdir -p $OUT_DIR

openssl req \
  -x509 \
  -nodes \
  -newkey rsa:2048 \
  -keyout $OUT_DIR/root-ca-private.pem \
  -out $OUT_DIR/root-ca-crt.pem \
  -outform PEM \
  -days 9999 \
  -subj "$SUBJ"

