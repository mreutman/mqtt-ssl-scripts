# MQTT SSL Scripts

## About

The following are some scripts I wrote to help generate key files MQTT SSL
encryption. If run correctly, you will end with creating self signed keys
and certificates for both the client (e.x. embedded device like the ESP32) and
the server (e.x. Mosquitto MQTT broker).

## Instructions

Create subj.conf using subj.conf.example as a reference, setting the values
to what make sense for you. Then run the scripts in the following order.

```
$ ./create-root-ca.sh
$ ./create-server.sh
$ ./create-client.sh
```

At the conclusion of this, the key files can be found in `./root`, `./server`,
and `./client` respectively.
