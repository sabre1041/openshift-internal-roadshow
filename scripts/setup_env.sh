#!/bin/bash

set -e

# Global variables
NUM_USERS=30
USER_PREFIX=
USER_BASE=user
PASSWORD=redhat
OSE_GROUP=roadshow-users
OSE_ROLE=view
OSE_PROJECT=ose-roadshow-demo
OSE_DOMAIN=ose.example.com
OSE_APP_SUBDOMAIN=apps

PASSWD_FILE=/etc/origin/openshift-passwd

# Show script usage
usage() {
  echo "
  Usage: $0 [options]

  Options:
  --user-base=<user base>          : Base user name (Default: user)
  --user-prefix=<user prefix>      : User prefix
  --num-users=<num users>          : Number of Users to provision (Default: 30)
  --group=<group>                  : Name of the group to create (Default: roadshow-users)
  --role=<role>                    : Name of the role to give to the newly created group for the demo project (Default: view)
  --project=<project>              : Name of the demo project to create (Default: ose-roadshow-demo)
  --domain=<domain>                : Domain name for smoke test route (Default: ose.example.com)
  --app-subdomain=<app subdomain>  : Subdomain name for smoke test route (Default: apps)
  --passwd-file=<passwd file>      : OpenShift htpasswd file (Default: /etc/origin/openshift-passwd)
   "
}



# Process input
for i in "$@"
do
  case $i in
    --user-base=*)
      USER_BASE="${i#*=}"
      shift;;
    --user-prefix=*)
      USER_PREFIX="${i#*=}"
      shift;;
    --num-users=*)
      NUM_USERS="${i#*=}"
      shift;;
    --group=*)
      OSE_GROUP="${i#*=}"
      shift;;
    --role=*)
      OSE_ROLE="${i#*=}"
      shift;;
    --project=*)  
      OSE_PROJECT="${i#*=}"
      shift;;
    --domain=*)  
      OSE_DOMAIN="${i#*=}"
      shift;;
    --app-subdomain=*)  
      OSE_APP_SUBDOMAIN="${i#*=}"
      shift;;
    --passwd-file=*)  
      PASSWD_FILE="${i#*=}"
      shift;;
     *)
      echo "Invalid Option: ${i#*=}"
      exit 1;
      ;;
  esac
done

users=

for i in $(seq -f "%02g" 0 $NUM_USERS)
do
	
	username=${USER_PREFIX}${USER_BASE}${i}
  
	# Create new Users
	htpasswd -b ${PASSWD_FILE} $username ${PASSWORD}
	
	# Create Comma Separated List for Groups
	users+="\"${username}\","
	
done


# Hold current project name to switch back into
current_project=$(oc project --short)

	oc project default &>/dev/null

echo "{ \"kind\": \"Group\", \"apiVersion\": \"v1\", \"metadata\": { \"name\": \"${OSE_GROUP}\", \"creationTimestamp\": null }, \"users\": [ ${users%?} ] }" | oc create -f -

oc new-project ${OSE_PROJECT} --display-name="OpenShift Roadshow Demo" --description="OpenShift Roadshow Demo Project"

oadm policy add-role-to-group ${OSE_ROLE} ${OSE_GROUP}  -n ${OSE_PROJECT}

oc new-app https://github.com/gshipley/smoke -n ${OSE_PROJECT}

oc scale dc smoke --replicas=2 -n ${OSE_PROJECT} &>/dev/null

oc expose service smoke --hostname=smoketest.${OSE_APP_SUBDOMAIN}.${OSE_DOMAIN} &>/dev/null

oc project $current_project &>/dev/null




