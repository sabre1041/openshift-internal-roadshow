#** Lab 0: Environment Overview **

You will be interacting with an OpenShift environment that is installed on top
of Red Hat's internal cloud, OS1. The OpenShift environment 
consists of the following:

* One OpenShift Master that also includes a Node providing an "infra"(structure) region
* Four OpenShift Nodes providing the "primary" region

The OpenShift Master provides both the API endpoint for the CLI as well as the
OpenShift web console. It is essentially the only system you will directly
interact with.

The "infra(structure)" region is where OpenShift's internal Docker registry and
OpenShift's router are running. The "primary" region is where all of your builds
and application instances will run. 

This topology of "infra" and "primary" is completely configurable and very advanced topologies can be crafted to suit the needs of your organization.

The environment was provisioned via utilities produced by the [Container Automation Solutions Lab](https://mojo.redhat.com/groups/paas-community-of-practice/projects/container-automation-solutions-lab)