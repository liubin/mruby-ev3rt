
# mruby for ev3rt

Running mruby codes on EV3 by [ev3rt](http://dev.toppers.jp/trac_user/ev3pf/wiki/WhatsEV3RT).


```

# build
$ export EV3RT_MR_NAME=beta2.1.0
$ export image=ev3rt-mruby:${EV3RT_MR_NAME}
$ export codebase=/opt/mruby-on-ev3rt+tecs_package-${EV3RT_MR_NAME}/hr-tecs/workspace/mruby_app
$ docker build -t $image .

# copy code to local
$ docker run --rm -v `pwd`/work:/tmp $image cp -r ${codebase} /tmp/
$ ls -al work/mruby_app

# edit codes in local

# build with new code in container

$ docker run --rm -v `pwd`/work/mruby_app:${codebase} -v `pwd`/work/image:/tmp $image /build_app.sh
$ ls -al work/image/

# copy image to local
$ docker run --rm -v `pwd`/work/image:/tmp $image cp /cygdrive/e/uImage /tmp/uImage
$ ls -al work/image/
```