t_Log "Running $0 -  Check basic docker functionality"

t_Log 'Pulling image'

# Registry
registry='registry.test.altiscale.com'
[ -z $REGISTRY ] || registry=$REGISTRY

# Default image
image='prometheus-6.5.14-201602120407'

# if image id is supplied as env variable
[ -z "$PROMETHEUS" ] || image=$PROMETHEUS

# if image id is supplied as arg to this script
[ -z $image ] || [ $# -eq 0 ] || image=$1

docker pull ${registry}/${image}
t_CheckExitStatus $? "FAIL: Docker can not pull the image ${registry}/${image}"

docker images | grep "$registry/$image"
t_CheckExitStatus $? "FAIL: Docker can not find pulled image ${registry}/${image} in images list"

t_Log 'Running basic command inside container'
docker run --rm=true ${registry}/${image} hostname
t_CheckExitStatus $? "FAIL: Can not run basic command on a container"

t_Log 'Removing container image'
docker rmi ${registry}/${image}
t_CheckExitStatus $? "FAIL: Can not remove image ${registery}/${image}"
