PYTHON=python3
PIP=pip3

BUILD_DIR=./build
LAYER_FILE=${BUILD_DIR}/layer.zip
PACKAGE_FILE=${BUILD_DIR}/package.zip
PACKAGE_SOURCE=lambda_request.py lambda_env.py secrets_manager.py sftp_helpers.py key_helpers.py boto_helpers.py requirements.txt
TEST_FILES=$(wildcard *.test.py)

all: lint test dist

# Build from a clean tmp directory using the same requirements used in venv
${LAYER_FILE}: Makefile requirements.txt
	mkdir -p ${BUILD_DIR} && \
	PYTHON_TEMPDIR=`mktemp -d ./python.XXXXXXXX` &&                     \
	${PYTHON} -m venv $${PYTHON_TEMPDIR}/python &&                      \
	. ./$${PYTHON_TEMPDIR}/python/bin/activate &&                       \
	${PIP} install -r requirements.txt &&                               \
	if [ -e $@ ]; then                                                  \
		rm $@;                                                      \
	fi &&                                                               \
	(cd $${PYTHON_TEMPDIR} && zip -qyr ../$@ python && cd ..) &&        \
	(ls -1 ./$${PYTHON_TEMPDIR}/python/lib | tr -d '\n'> ${BUILD_DIR}/PYTHON_VERSION) && \
	(cd $${PYTHON_TEMPDIR} && rm -rf ./python/*) &&                     \
	rmdir $${PYTHON_TEMPDIR}/python &&                                  \
	rmdir $${PYTHON_TEMPDIR}

.PHONY: layer
layer: ${LAYER_FILE}

${PACKAGE_FILE}: Makefile ${PACKAGE_SOURCE}
	mkdir -p ${BUILD_DIR} && \
	zip $@ ${PACKAGE_SOURCE}

.PHONY: package
package: ${PACKAGE_FILE}

dist: ${LAYER_FILE} ${PACKAGE_FILE}

venv/pyvenv.cfg: requirements.txt test_requirements.txt
	${PYTHON} -m venv venv;                 \
	. ./venv/bin/activate;                  \
	${PIP} install -r requirements.txt;     \
	${PIP} install -r test_requirements.txt; \
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
