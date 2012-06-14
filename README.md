# heroku-spiped

## Dependencies

install spiped from http://www.tarsnap.com/spiped.html
For mac, you need to remove the `-lrt` from the `Makefile`

## You can run this locally

    cp .env.example .env
    bundle
    bundle exec foreman start

visit http://localhost:5000/raw to see raw ZMQ
visit http://localhost:5000/spiped to see spiped ZMQ

## Now run it on heroku

choose a place to run your spiped decrypter/server or tunnel it via SSH/VPN

    scp key ip.of.your.server:/tmp/spiped.key
    spiped -d -F -s 0.0.0.0:7001 -t 127.0.0.1:7002 -k /tmp/spiped.key

    heroku create --buildpack https://github.com/ddollar/heroku-buildpack-multi --stack cedar spiped-for-me

    heroku config:add \
      LD_LIBRARY_PATH=sw/usr/lib \
      PATH=sw/usr/bin:bin:vendor/bundle/ruby/1.9.1/bin:/usr/local/bin:/usr/bin:/bin \
      SPIPED_CLIENT_SOURCE_SOCKET=/tmp/spiped.sock \
      SPIPED_CLIENT_TARGET_SOCKET=ip.of.your.server:7001 \
      ZMQ_CONNECT_URI=tcp://ip.of.your.server:7002

    heroku ps:scale web=1

    heroku logs --tail

Now you can visit http://spiped-for-me.herokuapp.com/spiped
