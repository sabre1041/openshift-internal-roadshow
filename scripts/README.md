# Initialization Scripts

This directory contains scripts to support the demo environment

## Environment Setup

The `setup_env.sh` script can be used to prepare an existing OpenShift environment for the demo by performing the following actions

* Creating a set of test users
* Creating a demo project that is available as a read only project for participants
* Create a demo application for users to explore how builds, deployments and monitoring works in OpenShift
	* Expose application so the user interface is publicly available

### Execution

The script must be executed on the OpenShift master as a user with *cluster-admin* permissions.

The following parameters are available to customize the behavior of the script

|Name| Description | Default Value|
|--------|----------------|--------------------|
|--user-base|Base Username|user|
|--user-prefix|Username prefix| |
|--num-users|Number of users to provision|30|
|--password|Password for each user| redhat
|--group|Name of the group containing demo users | roadshow-users|
|--role | Cluster role to apply for the demo group in the demo project | view |
|--project | Name of the demo project to create | ose-roadshow-demo |
|--domain | Name of the domain to use for the demo application route | ose.example.com |
|--app-subdomain| Name of application subdomain | apps |
| --passwd-file| Location of the HTPassd file for creating users | /etc/origin/openshift-passwd |


