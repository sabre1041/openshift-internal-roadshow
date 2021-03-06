#**Lab 3: Creating Routes by Exposing Services**

###**Background: Routes**

By default, the *new-app* command does not expose the Service it creates to the
outside world. If you want expose a service as an HTTP endpoint you can easily
do this with a Route. The OpenShift router uses the host HTTP header to
determine where to proxy the incoming request. You can optionally define
security, such as TLS, for the route. If you want your Pods to be accessible to
the outside world, you need to create a route.

####**Exercise 2: Creating a route**

Fortunately, creating a Route is a pretty straight-forward process.  You simply
expose the Service. First we want to verify that we don't already have any
existing routes:

	$ oc get routes

An empty response indicates no routes are available.

Now we need to get the Service name to expose:

	$ oc get services

    NAME        CLUSTER_IP       EXTERNAL_IP   PORT(S)    SELECTOR                                   AGE
    guestbook   172.30.149.111   <none>        3000/TCP   app=guestbook,deploymentconfig=guestbook   4h

Once we know the Service name, creating a route is a simple one-command task:

	$ oc expose service guestbook

Verify the route was created with the following command:

	$ oc get routes

    NAME        HOST/PORT                                                                PATH      SERVICE     LABELS          INSECURE POLICY   TLS TERMINATION
    guestbook   guestbook-oseuser-guestbook.apps.city-roadshow.rhc-ose.labs.redhat.com             guestbook   app=guestbook

You can also verify the route by looking at the project in OpenShift web console:

![Project Overview with Route](../images/route.png)

Pretty nifty, huh?  This application is now available at the above URL:

![Guestbook Application](../images/route2.png)

**End of Lab 3**