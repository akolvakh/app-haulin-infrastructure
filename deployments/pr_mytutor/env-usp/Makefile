ROOT_DIR=$(shell git rev-parse --show-toplevel)
ENV_INCLUDES=$(shell ls -1 env-*.incl)
ENVIRONMENTS=$(subst env-,,$(ENV_INCLUDES))
ENVIRONMENTS=$(subst .incl,,$(ENV_INCLUDES))


# while we keep in same folder TF files for service deploy and infra (services to be moved into seprate repo)
# skip services TF code explicitly when (re)setup environment
# by naming convention: "[0-9]+.ecs_service*" 

SKIP_PATTERN=^[0-9]+\.ecs_service_.+$

COMMAND=@sh -c '\
echo run in $$1 ;\
for module in $$(find  -maxdepth 1  -type d -regex "\./[0-9]+.+" | sed "s/.\///"|sort -n -t "." -s) ; \
do \
( echo "=======START RUN MAKEFILE IN $$module======"; \
if [[ $$module =~ $(SKIP_PATTERN) ]]; then echo "SKIPPING $$module ";exit 0; fi; \
cd $$module; \
make env-$$1 && make $$2; \
echo "======FINISH RUN MAKEFILE IN $$module=====";) \
done ' COMMAND

ENV=$(shell readlink env.incl|sed 's/-env.incl//')
##########
#
#  TODO rectify copy paste from https://github.com/phoenix/phoenix-infrastructure/blob/develop/incl/Makefile.incl#L10
#  I dont want include $ROOT_DIR/incl/Makefile to prevent naming conflcit for make init, make plan, defined there.
#  Need reorgnize Make includes a bit - make them more granular. Later Phil
#
##########
default:
	@if [ ! -e env.incl ]; then \
	echo "First set the env.incl link by running make like 'make env-dev'"; \
	fi

# Change the environment incl file
define ENV_template
.PHONY: env-$(1)
env-$(1):
	@if [ -e env-$(1).incl ]; then                           \
	        rm -f env.incl;                                  \
	        ln -s env-$(1).incl env.incl;                    \
	        echo env.incl now points to `readlink env.incl`; \
	else                                                     \
	        echo env-$(1).incl does not exist!!!.;              \
	fi
endef

$(foreach env,$(ENVIRONMENTS),$(eval $(call ENV_template,$(env))))



plan:
	$(COMMAND) $(ENV) plan

apply:
	$(COMMAND) $(ENV) apply


clean:
	$(COMMAND) $(ENV) clean	





# ROOT_DIR=$(shell git rev-parse --show-toplevel)
# ENV_INCLUDES=$(shell ls -1 env-*)
# # ENVIRONMENTS=$(subst env-,,$(ENV_INCLUDES))
# ENVIRONMENTS=$(subst -*.incl,,$(ENV_INCLUDES))

# # while we keep in same folder TF files for service deploy and infra (services to be moved into seprate repo)
# # skip services TF code explicitly when (re)setup environment
# # by naming convention: "[0-9]+.ecs_service*" 

# SKIP_PATTERN=^[0-9]+\.ecs_service_.+$

# COMMAND=@sh -c '\
# echo run in $$1 ;\
# for module in $$(find  -maxdepth 1  -type d -regex "\./[0-9]+.+" | sed "s/.\///"|sort -n -t "." -s) ; \
# do \
# ( echo "=======START RUN MAKEFILE IN $$module======"; \
# if [[ $$module =~ $(SKIP_PATTERN) ]]; then echo "SKIPPING $$module ";exit 0; fi; \
# cd $$module; \
# make $$1-env && make $$2; \
# echo "======FINISH RUN MAKEFILE IN $$module=====";) \
# done ' COMMAND

# ENV=$(shell readlink env.incl|sed 's/env-//')
# # ENV=$(shell readlink env.incl|sed 's/-env.incl//')
# ##########
# #
# #  TODO rectify copy paste from https://github.com/phoenix/phoenix-infrastructure/blob/develop/incl/Makefile.incl#L10
# #  I dont want include $ROOT_DIR/incl/Makefile to prevent naming conflcit for make init, make plan, defined there.
# #  Need reorgnize Make includes a bit - make them more granular.
# #
# ##########
# default:
# 	@if [ ! -e env.incl ]; then \
# 	echo "First set the env.incl link by running make like 'make env-dev'"; \
# 	fi

# # Change the environment incl file
# define ENV_template
# .PHONY: env-$(1)
# env-$(1):
# 	@if [ -e env-$(1).incl ]; then                           \
# 	        rm -f env.incl;                                  \
# 	        ln -s env-$(1).incl env.incl;                    \
# 	        echo env.incl now points to `readlink env.incl`; \
# 	else                                                     \
# 	        echo env-$(1).incl does not exist.;              \
# 	fi
# endef

# $(foreach env,$(ENVIRONMENTS),$(eval $(call ENV_template,$(env))))



# plan:
# 	$(COMMAND) $(ENV) plan

# apply:
# 	$(COMMAND) $(ENV) apply


# clean:
# 	$(COMMAND) $(ENV) clean	





