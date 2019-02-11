#!/bin/sh

BASE=$(realpath $(dirname $0))

if [ ! -f $BASE/subj.conf ]; then
  echo "File $BASE/subj.conf not found!"
  exit 1
fi

# Import settings.
. $BASE/subj.conf

C=$MQTT_C
ST=$MQTT_ST
L=$MQTT_L
O=$MQTT_O
OU=$MQTT_OU
CN=$MQTT_CN

SUBJ="/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN"
OUT_DIR="$BASE/server"
ROOT_DIR="$BASE/root"
mkdir -p $OUT_DIR

# Generate cert request and key.
openssl req \
  -nodes \
  -newkey rsa:2048 \
  -keyout $OUT_DIR/server-private.pem \
  -out $OUT_DIR/server-csr.pem \
  -outform PEM \
  -days 9999 \
  -subj "$SUBJ"

# Sign request with root CA.
openssl x509 \
  -req \
  -in $OUT_DIR/server-csr.pem \
  -CA $ROOT_DIR/root-ca-crt.pem \
  -CAkey $ROOT_DIR/root-ca-private.pem \
  -CAcreateserial \
  -out $OUT_DIR/server-crt.pem
