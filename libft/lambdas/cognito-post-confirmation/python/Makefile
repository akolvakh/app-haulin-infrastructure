PYTHON=python3
PIP=pip3

BUILD_DIR=./build
LAYER_FILE=${BUILD_DIR}/cognito_post_confirmation_lambda_layer.zip
PACKAGE_FILE=${BUILD_DIR}/cognito_post_confirmation_lambda_package.zip
PACKAGE_SOURCE=lambda_request.py cognito.py requirements.txt
TEST_FILES=$(wildcard *.test.py)

all: lint test

venv/pyvenv.cfg: requirements.txt test_requirements.txt
	${PYTHON} -m venv venv;                 \
	. ./venv/bin/activate;                  \
	${PIP} install -r requirements.txt;     \
	${PIP} install -r test_requirements.txt; \
	${PIP} install pylint

venv: venv/pyvenv.cfg

lint.txt: *.py venv
	@. ./venv/bin/activate && ((./venv/bin/python3 `which pylint` *.py > $@) || echo "Lint has failed: See lint.txt")

lint: lint.txt
	@cat lint.txt

.PHONY: test 
test: lint
	@for test in `echo ${TEST_FILES}`; do\
		echo "Running: $$test";\
		. ./venv/bin/activate && ${PYTHON} $$test;\
	done;

.PHONY: coverage
coverage: coverage
	@. ./venv/bin/activate && coverage run lambda_request.test.py
	@. ./venv/bin/activate && coverage html

clean: 
	-rm -rf ./${BUILD_DIR} ./venv ./__pycache__
	-rm -f lint.txt ${PACKAGE_FILE}
	-rm -rf ./.coverage ./htmlcov
 