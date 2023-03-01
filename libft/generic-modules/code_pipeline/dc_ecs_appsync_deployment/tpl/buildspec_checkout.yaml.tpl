version: 0.2

env:
  shell: bash
  git-credential-helper: yes
  exported-variables:
    - VERSION_NAME

phases:
  build:
    commands:
      - echo "Checking out to $VERSION"
      - git checkout $VERSION
  post_build:
    commands:
      - |
        export TAG_RE='^v([[:digit:]]+)\.([[:digit:]]+)\.([[:digit:]]+)'
        case $VERSION in
          'HEAD' | 'latest')
            export TAG=$(git describe --tags --abbrev=0)
            ;;
          *)
            export TAG=$VERSION
            ;;
        esac
        [[ $TAG =~ $TAG_RE ]]
        MAJOR=${BASH_REMATCH[1]}
        MINOR=${BASH_REMATCH[2]}
        PATCH=${BASH_REMATCH[3]}
        case $VERSION in
          'HEAD' | 'latest')
            COMMIT_HASH=$(git rev-parse $VERSION)
            export VERSION_NAME=${MAJOR}.${MINOR}.${PATCH}-${COMMIT_HASH:0:7}.${CODEBUILD_BUILD_NUMBER}
            ;;
          *)
            export VERSION_NAME=${MAJOR}.${MINOR}.${PATCH}-${CODEBUILD_BUILD_NUMBER}
            ;;
        esac
        echo Version name: $VERSION_NAME
artifacts:
  files:
    - "**/*"
  exclude-paths:
    - "./.git"
  enable-symlinks: yes
