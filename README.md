# docker-mkdocs-material

`.gitlab-ci.yml` with Gitlab Pages support.

- add your SSH public certificate as a Gitlab project environment variable `SSH_PRIVATE_KEY` for production deployment:
   - Project's settings -> CI/CD -> Variables

```
variables:
  GIT_SUBMODULE_STRATEGY: recursive
  GIT_DEPTH: 1000
  GIT_STRATEGY: none
  IMAGE: "vignemail1/docker-mkdocs-material:latest"

stages:
  - build
  - deploy

build:
  stage: build
  image: "${IMAGE}"
  script:
    - rm -rf /docs
    - git clone $CI_REPOSITORY_URL /docs
    - cd /docs
    - mkdocs build -c -d $CI_PROJECT_DIR/public
    - cd $CI_PROJECT_DIR/
  artifacts:
    expire_in: 1 week
    paths:
      - public

pages:
  stage: deploy
  environment:
    url: "${CI_PAGES_URL}"
    name: pages
  script:
    - echo "Deploying site on Pages"
  artifacts:
    paths:
      - public
  only:
    - master
    
deploy_prod:
  image: "${IMAGE}"
  stage: deploy
  environment:
    name: production
    url: "https://xxx.domain.tld"
  before_script:
    - 'which ssh-agent || ( apt-get update -qqy && apt-get install -qqy openssh-client )'
    - apt install -y rsync git
    - eval $(ssh-agent -s)
    - echo "${SSH_PRIVATE_KEY}" | tr -d '\r' | ssh-add -
    - mkdir -p ~/.ssh
    - chmod 700 ~/.ssh
    - '[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config'
  script:
    - echo "Deploying site to production environment"
    - ssh -l ssh_user backend.domain.tld "mv -f /var/www/xxx.domain.tld/public{,.OLD}" || true
    - rsync -vr --delete public ssh_user@backend.domain.tld:/var/www/xxx.domain.tld/
  only:
    - master
  when: manual

```
