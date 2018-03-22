#!/bin/bash

if [ ! -f /haraka/config/smtp.ini ]; then
  haraka -i /haraka
fi

haraka -c /haraka
