PYTHON=python3
PIP=pip3
REGION=us-east-2

TEST_FILES=$(wildcard *.test.py)

all: lint test

venv/pyvenv.cfg: requirements.txt 
	${PYTHON} -m venv venv;                 \
	. ./venv/bin/activate;                  \
	${PIP} install -r requirements.txt;     \
	${PIP} install pylint

venv: venv/pyvenv.cfg

lint.txt: *.py venv
	. ./venv/bin/activate && ((./venv/bin/python3 `which pylint` *.py > $@) || echo "Lint has failed: See lint.txt")

lint: lint.txt
	@cat lint.txt

.PHONY: test 
test: lint
	@for test in `echo ${TEST_FILES}`; do\
		echo "Running: $$test";\
		export AWS_DEFAULT_REGION=${REGION};\
		. ./venv/bin/activate && ${PYTHON} $$test;\
	done;

clean: 
	-rm -rf ./${BUILD_DIR} ./venv ./__pycache__
	-rm -f lint.txt ${PACKAGE_FILE}
