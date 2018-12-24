#!/bin/sh

cd /opt/mruby-on-ev3rt+tecs_package-${EV3RT_MR_NAME}/hr-tecs/workspace/sd && \
  make mrb && \
  cp /cygdrive/e/uImage /tmp/uImage