# Домашнее задание к занятию "08.03 Работа с Roles"

## 1.

ok

## 2.
```
root@nM:/home/cht/netology/ansible/git/devops-netology/08-ansible-02-playbook/playbook# ansible-galaxy install -r requirements.yml --roles-path ./
Starting galaxy role install process
Enter passphrase for key '/root/.ssh/id_rsa':
- extracting java to /home/cht/netology/ansible/git/devops-netology/08-ansible-02-playbook/playbook/java
- java (1.0.1) was installed successfully
```


добавил в meta/main.yml
```
galaxy_info:
role_name: my_name  # if absent directory name hosting role is used instead
namespace: my_galaxy_namespace  # if absent, author is used instead
```
как было написано в сообщении об ошибке

```
root@nM:/home/cht/netology/ansible/git/devops-netology/08-ansible-02-playbook/playbook/java# molecule test
/usr/local/lib/python3.6/dist-packages/requests/__init__.py:104: RequestsDependencyWarning: urllib3 (1.26.11) or chardet (5.0.0)/charset_normalizer (2.0.12) doesn't match a supported version!
  RequestsDependencyWarning)
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/1cfa63/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/1cfa63/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/1cfa63/roles:/etc/ansible/roles
INFO     Using /etc/ansible/roles/my_galaxy_namespace.my_name symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos8)
ok: [localhost] => (item=centos7)
ok: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /home/cht/netology/ansible/git/devops-netology/08-ansible-02-playbook/playbook/java/molecule/default/converge.yml
INFO     Running default > create
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 0, 

u'ansible_index_var': u'i', u'changed': False})
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 1, 

u'ansible_index_var': u'i', u'changed': False})
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 

2, u'ansible_index_var': u'i', u'changed': False})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'45970116366.21995', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, 

u'name': u'centos8'}, u'finished': 0, u'results_file': u'/root/.ansible_async/45970116366.21995'})
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'107459973516.22021', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, 

u'name': u'centos7'}, u'finished': 0, u'results_file': u'/root/.ansible_async/107459973516.22021'})
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'451777103635.22064', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': 

True, u'name': u'ubuntu'}, u'finished': 0, u'results_file': u'/root/.ansible_async/451777103635.22064'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos8]
ok: [ubuntu]
ok: [centos7]

PLAY RECAP *********************************************************************
centos7                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
centos8                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

## 3.

```
root@nM:/home/cht/netology/ansible/git/ansible3/elastic# molecule init scenario --driver-name docker
INFO     Initializing new scenario default...
INFO     Initialized scenario in /home/cht/netology/ansible/git/ansible3/elastic/molecule/default successfully.
```

## 4.

```
root@nM:/home/cht/netology/ansible/git/ansible3/elastic# molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/365898/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/365898/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/365898/roles:roles:/etc/ansible/roles
INFO     Running default > dependency
INFO     Running ansible-galaxy collection install -v community.docker:>=1.9.1
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos7)
ok: [localhost] => (item=centos8)
ok: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /home/cht/netology/ansible/git/ansible3/elastic/molecule/default/converge.yml
INFO     Running default > create
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 0, 

u'ansible_index_var': u'i', u'changed': False})
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 1, 

u'ansible_index_var': u'i', u'changed': False})
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 

2, u'ansible_index_var': u'i', u'changed': False})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'335003192670.24868', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, 

u'name': u'centos7'}, u'finished': 0, u'results_file': u'/root/.ansible_async/335003192670.24868'})
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'983465962819.24894', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, 

u'name': u'centos8'}, u'finished': 0, u'results_file': u'/root/.ansible_async/983465962819.24894'})
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'170721755086.24937', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': 

True, u'name': u'ubuntu'}, u'finished': 0, u'results_file': u'/root/.ansible_async/170721755086.24937'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos8]
ok: [ubuntu]
ok: [centos7]

TASK [Include elastic] *********************************************************

PLAY RECAP *********************************************************************
centos7                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
centos8                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running default > idempotence
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos8]
ok: [ubuntu]
ok: [centos7]

TASK [Include elastic] *********************************************************

PLAY RECAP *********************************************************************
centos7                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
centos8                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
ok: [centos7] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [centos8] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [ubuntu] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
centos7                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
centos8                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

## 5.

```
root@nM:/home/cht/netology/ansible/git/ansible3# molecule init role --driver-name docker acme.kibana
/usr/local/lib/python3.6/dist-packages/requests/__init__.py:104: RequestsDependencyWarning: urllib3 (1.26.11) or chardet (5.0.0)/charset_normalizer (2.0.12) doesn't match a supported version!
  RequestsDependencyWarning)
INFO     Initializing new role kibana...
Using /etc/ansible/ansible.cfg as config file
- Role kibana was created successfully
localhost | CHANGED => {"backup": "", "changed": true, "msg": "line added"}
INFO     Initialized role in /home/cht/netology/ansible/git/ansible3/kibana successfully.
```

## 6.

```
root@nM:/home/cht/netology/ansible/git/ansible3/kibana# molecule test
/usr/local/lib/python3.6/dist-packages/requests/__init__.py:104: RequestsDependencyWarning: urllib3 (1.26.11) or chardet (5.0.0)/charset_normalizer (2.0.12) doesn't match a supported version!
  RequestsDependencyWarning)
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/c0c901/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/c0c901/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/c0c901/roles:/etc/ansible/roles
INFO     Using /etc/ansible/roles/acme.kibana symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /home/cht/netology/ansible/git/ansible3/kibana/molecule/default/converge.yml
INFO     Running default > create
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
skipping: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 0, 

u'ansible_index_var': u'i', u'changed': False})
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 1, 

u'ansible_index_var': u'i', u'changed': False})
ok: [localhost] => (item={u'item': {u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 

2, u'ansible_index_var': u'i', u'changed': False})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, u'name': u'centos8'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, u'name': u'centos7'})
ok: [localhost] => (item={u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': True, u'name': u'ubuntu'})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'448602791419.5035', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/centos:8', u'pre_build_image': True, 

u'name': u'centos8'}, u'finished': 0, u'results_file': u'/root/.ansible_async/448602791419.5035'})
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'640872948504.5062', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/centos:7', u'pre_build_image': True, 

u'name': u'centos7'}, u'finished': 0, u'results_file': u'/root/.ansible_async/640872948504.5062'})
changed: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'903394740229.5105', u'failed': False, u'started': 1, u'changed': True, u'item': {u'image': u'docker.io/pycontribs/ubuntu:latest', u'pre_build_image': 

True, u'name': u'ubuntu'}, u'finished': 0, u'results_file': u'/root/.ansible_async/903394740229.5105'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos8]
ok: [ubuntu]
ok: [centos7]

TASK [Include acme.kibana] *****************************************************

TASK [acme.kibana : Upload tar.gz Kibana from remote URL] **********************
FAILED - RETRYING: Upload tar.gz Kibana from remote URL (3 retries left).
FAILED - RETRYING: Upload tar.gz Kibana from remote URL (3 retries left).
FAILED - RETRYING: Upload tar.gz Kibana from remote URL (3 retries left).
changed: [centos7]
changed: [centos8]
changed: [ubuntu]

TASK [acme.kibana : Create directrory for Kibana (/opt/kibana/7.7.0)] **********
changed: [centos7]
changed: [ubuntu]
changed: [centos8]

TASK [acme.kibana : Extract Kibana in the installation directory] **************
changed: [ubuntu]
changed: [centos8]
changed: [centos7]

TASK [acme.kibana : Set environment Kibana] ************************************
changed: [centos7]
changed: [ubuntu]
changed: [centos8]

PLAY RECAP *********************************************************************
centos7                    : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
centos8                    : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running default > idempotence
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos8]
ok: [ubuntu]
ok: [centos7]

TASK [Include acme.kibana] *****************************************************

TASK [acme.kibana : Upload tar.gz Kibana from remote URL] **********************
ok: [centos8]
ok: [ubuntu]
ok: [centos7]

TASK [acme.kibana : Create directrory for Kibana (/opt/kibana/7.7.0)] **********
ok: [centos7]
ok: [ubuntu]
ok: [centos8]

TASK [acme.kibana : Extract Kibana in the installation directory] **************
skipping: [centos7]
skipping: [centos8]
skipping: [ubuntu]

TASK [acme.kibana : Set environment Kibana] ************************************
ok: [centos7]
ok: [ubuntu]
ok: [centos8]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
centos8                    : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
ok: [centos7] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [centos8] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [ubuntu] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
centos7                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
centos8                    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
[WARNING]: ansible.utils.display.initialize_locale has not been called, this
may result in incorrectly calculated text widths that can cause Display to
print incorrect line lengths

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

## 7.

ok

## 8.

ok

## 9.

```
root@nM:/home/cht/netology/ansible/git/devops-netology/08-ansible-02-playbook/playbook# ansible-playbook -i inventory/prod.yml site_roles.yml
[WARNING]: While constructing a mapping from /home/cht/netology/ansible/git/devops-netology/08-ansible-02-playbook/playbook/roles/kibana/tasks/main.yml, line 4, column 7, found a duplicate dict key (url). Using last defined value only.
[WARNING]: ansible.utils.display.initialize_locale has not been called, this may result in incorrectly calculated text widths that can cause Display to print incorrect line lengths

PLAY [all] 

**********************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [elastic : Upload tar.gz Elasticsearch from remote URL] 

********************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [elastic : Create directrory for Elasticsearch] 

****************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [elastic : Extract Elasticsearch in the installation directory] 

************************************************************************************************************************************************************************
skipping: [elasticsearch]

TASK [elastic : Set environment Elastic] 

****************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [kibana : Upload tar.gz Kibana from remote URL] 

****************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [kibana : Create directrory for Kibana (/opt/kibana/)] 

*********************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [kibana : Extract Kibana in the installation directory] 

********************************************************************************************************************************************************************************
skipping: [elasticsearch]

TASK [kibana : Set environment Kibana] 

******************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [java : Upload .tar.gz file containing binaries from local storage] 

********************************************************************************************************************************************************************
skipping: [elasticsearch]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] 

********************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [java : Ensure installation dir exists] 

************************************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [java : Extract java in the installation directory] 

************************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [java : Export environment variables] 

**************************************************************************************************************************************************************************************************
changed: [elasticsearch]

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
elasticsearch              : ok=11   changed=3    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
```

## 10.

ok

## 11.

https://github.com/SergeV11/elastic-role

https://github.com/SergeV11/kibana-role

https://github.com/SergeV11/playbook


