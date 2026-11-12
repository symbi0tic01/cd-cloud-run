include ../../../make.inc
include .env
export

build_docker_image:
		docker build -t base-image-fastapi:prod -f Dockerfile .
		docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "${DOCKER_IMAGE_NAME}"

run_docker_image:
		docker run --rm -it -e PORT=${PORT} -p 8000:${PORT} "${DOCKER_IMAGE_NAME}"

push_docker_image:
		docker push "${DOCKER_IMAGE_NAME}"

deploy_docker_image:
		gcloud run deploy base-image-fastapi \
		--image ${DOCKER_IMAGE_NAME} \
		--region ${LOCATION} \
		--allow-unauthenticated
