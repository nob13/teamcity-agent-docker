Fork Notice:
============
This fork is for internal use. It adds the CA Key of [ReactiveCore](https://www.reactivecore.de) to the CA list, don't trust it!

Other changes
* Added MongoDB and [MongoFaker]( https://github.com/reactivecore/mongofaker)
* Added PhantomJS
```
docker run -d --name teamcity_agent --privileged -e TEAMCITY_SERVER=http://teamcity.lan:8111 -p 9090:9090 nob13/teamcity-agent-docker:latest
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
