version: 0.2

env:
  shell: bash
  git-credential-helper: yes
  exported-variables:
    - DOCKER_TAG

phases:
  pre_build:
    commands:
      - |
        export TAG_RE='^v?([[:digit:]]+)\.([[:digit:]]+)\.([[:digit:]]+)'
        case $VERSION in
          'HEAD')
            export DOCKER_TAG=$(git rev-parse HEAD)
            ;;
          'latest')
            export DOCKER_TAG='latest'
            ;;
          *)
            [[ $VERSION =~ $TAG_RE ]]

            MAJOR=${BASH_REMATCH[1]}
            MINOR=${BASH_REMATCH[2]}
            PATCH=${BASH_REMATCH[3]}

            export DOCKER_TAG="${MAJOR}.${MINOR}.${PATCH}"
            ;;
        esac
        echo "Docker tag: $DOCKER_TAG"
  build:
    commands:
      - echo "Checking out to $VERSION"
      - git checkout $VERSION

artifacts:
  files:
    - "**/*"
  exclude-paths:
    - "./.git"
  enable-symlinks: yes
