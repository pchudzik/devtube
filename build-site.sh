#!/usr/bin/env bash

docker run \
	--rm \
	-it \
	-v $(pwd):/site \
	-v $(pwd)/dist:/dist \
	hugo-conferences build
