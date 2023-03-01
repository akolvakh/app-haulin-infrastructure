# To switch environments run:
#   make dev-env
#   make prod-env
# dev-env.incl, prod-env.incl should exist.
$(shell ln -sf ../env-dev.incl)
$(shell ln -sf ../env-staging.incl)
$(shell ln -sf ../env-prod.incl)
$(shell ln -sf ../env-experimental.incl)
$(shell ln -sf ../env-qa.incl)

# Default settings.
include ../default.incl

#
# Common rules and dependencies
#
ROOT_DIR=$(shell git rev-parse --show-toplevel)

include $(ROOT_DIR)/framework/incl/Makefile.incl
