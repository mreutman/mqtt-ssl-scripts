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
OUT_DIR="$BASE/client"
ROOT_DIR="$BASE/root"
mkdir -p $OUT_DIR

# Generate cert request and key.
openssl req \
  -nodes \
  -newkey rsa:2048 \
  -keyout $OUT_DIR/client-private.pem \
  -out $OUT_DIR/client-csr.pem \
  -outform PEM \
  -days 9999 \
  -subj "$SUBJ"

# Sign request with root CA.
openssl x509 \
  -req \
  -in $OUT_DIR/client-csr.pem \
  -CA $ROOT_DIR/root-ca-crt.pem \
  -CAkey $ROOT_DIR/root-ca-private.pem \
  -CAserial $ROOT_DIR/root-ca-crt.srl \
  -out $OUT_DIR/client-crt.pem
