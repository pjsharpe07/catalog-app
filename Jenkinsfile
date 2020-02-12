pipeline {
  agent any
  stages {
    stage('deploy') {
      when { anyOf { branch 'master' } }
      environment {
        ANSIBLE_VAULT_FILE = credentials('ansible-vault-secret')
        SSH_KEY_FILE = credentials('datagov-sandbox')
      }
      steps {
        ansiColor('xterm') {
          sh 'docker run --rm -v $SSH_KEY_FILE:$SSH_KEY_FILE -v $ANSIBLE_VAULT_FILE:$ANSIBLE_VAULT_FILE -u $(id -u) datagov/datagov-deploy:latest pipenv run ansible-playbook --key-file=$SSH_KEY_FILE --vault-password-file=$ANSIBLE_VAULT_FILE --inventory inventories/ci --skip-tags database catalog.yml'
        }
      }
    }
  }
}
