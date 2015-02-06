Fork Notice:
============
This fork also adds the mongodb server. It's not running (because it's just a container) but [MongoFaker]( https://github.com/reactivecore/mongofaker) can use the executable to spin up a MongoDB instance during tests of Play  Applications.

Startup Call:
```
docker run -d --name teamcity_agent --privileged -e TEAMCITY_SERVER=http://teamcity.lan:8111 -p 90
90:9090 nob13/teamcity_agent:latest
```

Thanks to Sjoerd Mulder for the original version.


Teamcity build agent
========================

This is a teamcity build agent docker image, it uses docker in docker from https://github.com/jpetazzo/dind to allow you to start docker images inside of it :)
When starting the image as container you must set the TEAMCITY_SERVER environment variable to point to the teamcity server e.g.
```
docker run -e TEAMCITY_SERVER=http://localhost:8111
```

Optionally you can specify your ownaddress using the `TEAMCITY_OWN_ADDRESS` variable.

Linking example
--------
```
docker run -d --name=teamcity-agent-1 --link teamcity:teamcity --privileged -e TEAMCITY_SERVER=http://teamcity:8111 sjoerdmulder/teamcity-agent:latest
```
