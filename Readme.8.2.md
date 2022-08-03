# Домашнее задание к занятию "08.02 Работа с Playbook"

## 1.
```
cat inventory/prod.yml
---
  el:
    hosts:
      elasticsearch:
        ansible_connection: docker
#  deb:
#    hosts:
#      ubuntu:
#        ansible_connection: docker
```

## 2.

```
+
```

## 3.

```
+
```

## 4.
```
- name: Install kibana
  hosts: all
  tasks:
    - name: Download kibana
      get_url:
        url: http://66.98.117.133/kibana-{{ kibana_version }}-linux-x86_64.tar.gz
        dest: /tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz
        mode: 0755
        timeout: 60
        force: true
        validate_certs: false
      register: get_kibana
      until: get_kibana is succeeded
      tags: kibana
    - name: Create directrory for kibana
      file:
        state: directory
        path: "{{ kibana_home }}"
      tags: kibana
    - name: Extract Kibana in the installation directory
      #become: true
      unarchive:
        copy: false
        src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "{{ kibana_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ kibana_home }}/bin/kibana"
      tags: kibana
    - name: Set environment Kibana
    #become: true
      template:
        src: templates/kbn.sh.j2
        dest: /etc/profile.d/kbn.sh
  tags: kibana
```

## 5.

```
+
```

## 6.
```
ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: ansible.utils.display.initialize_locale has not been called, this may result in incorrectly calculated text widths that can cause Display to print incorrect line lengths

PLAY [Install Java] 

*************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Set facts for Java 11 vars] 

***********************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Upload .tar.gz file containing binaries from local storage] 

***************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [Ensure installation dir exists] 

*******************************************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [Extract java in the installation directory] 

*******************************************************************************************************************************************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: OSError: [Errno 17] File exists: '/root/.ansible'
fatal: [elasticsearch]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.11' must be an existing dir"}

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
elasticsearch              : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
```

## 7.

```
ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: ansible.utils.display.initialize_locale has not been called, this may result in incorrectly calculated text widths that can cause Display to print incorrect line lengths

PLAY [Install Java] 

*************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Set facts for Java 11 vars] 

***********************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Upload .tar.gz file containing binaries from local storage] 

***************************************************************************************************************************************************************************
diff skipped: source file size is greater than 104448
changed: [elasticsearch]

TASK [Ensure installation dir exists] 

*******************************************************************************************************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/jdk/11.0.11",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elasticsearch]

TASK [Extract java in the installation directory] 

*******************************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [Export environment variables] 

*********************************************************************************************************************************************************************************************************
--- before
+++ after: /root/.ansible/tmp/ansible-local-33180jpdDy/tmpyxMmQA/jdk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export JAVA_HOME=/opt/jdk/11.0.11
+export PATH=$PATH:$JAVA_HOME/bin
\ No newline at end of file

changed: [elasticsearch]

PLAY [Install Elasticsearch] 

****************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Upload tar.gz Elasticsearch from remote URL] 

******************************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [Create directrory for Elasticsearch] 

**************************************************************************************************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/elastic/",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elasticsearch]

TASK [Extract Elasticsearch in the installation directory] 

**********************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [Set environment Elastic] 

**************************************************************************************************************************************************************************************************************
--- before
+++ after: /root/.ansible/tmp/ansible-local-33180jpdDy/tmp_JjNbb/elk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export ES_HOME=/opt/elastic/
+export PATH=$PATH:$ES_HOME/bin
\ No newline at end of file

changed: [elasticsearch]

PLAY [Install kibana] 

***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Download kibana] 

**********************************************************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [Create directrory for kibana] 

*********************************************************************************************************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/kibana/",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elasticsearch]

TASK [Extract Kibana in the installation directory] 

*****************************************************************************************************************************************************************************************
changed: [elasticsearch]

TASK [Set environment Kibana] 

***************************************************************************************************************************************************************************************************************
--- before
+++ after: /root/.ansible/tmp/ansible-local-33180jpdDy/tmp0V2GxS/kbn.sh.j2
@@ -0,0 +1,4 @@
+#!/usr/bin/env bash
+
+export KIBANA_HOME=/opt/kibana/
+export PATH=$PATH:$KIBANA_HOME/bin

changed: [elasticsearch]

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
elasticsearch              : ok=16   changed=12   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 8.

```
ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: ansible.utils.display.initialize_locale has not been called, this may result in incorrectly calculated text widths that can cause Display to print incorrect line lengths

PLAY [Install Java] 

*************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Set facts for Java 11 vars] 

***********************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Upload .tar.gz file containing binaries from local storage] 

***************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Ensure installation dir exists] 

*******************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Extract java in the installation directory] 

*******************************************************************************************************************************************************************************************
skipping: [elasticsearch]

TASK [Export environment variables] 

*********************************************************************************************************************************************************************************************************
ok: [elasticsearch]

PLAY [Install Elasticsearch] 

****************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Upload tar.gz Elasticsearch from remote URL] 

******************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Create directrory for Elasticsearch] 

**************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Extract Elasticsearch in the installation directory] 

**********************************************************************************************************************************************************************************
skipping: [elasticsearch]

TASK [Set environment Elastic] 

**************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

PLAY [Install kibana] 

***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Download kibana] 

**********************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Create directrory for kibana] 

*********************************************************************************************************************************************************************************************************
ok: [elasticsearch]

TASK [Extract Kibana in the installation directory] 

*****************************************************************************************************************************************************************************************
skipping: [elasticsearch]

TASK [Set environment Kibana] 

***************************************************************************************************************************************************************************************************************
ok: [elasticsearch]

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
elasticsearch              : ok=13   changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
```

## 9.

```
+
```

## 10.

```
+
```
