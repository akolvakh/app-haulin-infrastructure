#!/usr/bin/env bash

docker run --rm -v $(pwd):/data -t ghcr.io/terraform-linters/tflint