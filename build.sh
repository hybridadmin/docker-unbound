
BUILD_VERSION=$1

if [ -f ${BUILD_VERSION}/Dockerfile ]; then
        docker build -f ${BUILD_VERSION}/Dockerfile -t hybridadmin/unbound:${BUILD_VERSION} .
else
        echo -e "No Dockerfile for build version ${BUILD_VERSION}"
fi
