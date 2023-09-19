## Ansible Playbook for Kind E2E Setup README

#### This Ansible playbook performs the following tasks:

    Installing necessary packages on EC2
    Installing Docker
    Installing Kind (Kubernetes in Docker)


## Playbook Structure

The playbook is organized as follows:

```yaml
    pre_tasks:
    - name: Install Updates (yum Package Manager)
      tags: always
      yum:
        update_only: true
        update_cache: yes
        state: latest
      when: ansible_pkg_mgr == "yum"
    
    - name: Install Updates (apt Package Manager)
      tags: always
      apt:
        upgrade: yes
        update_cache: yes
        state: latest
      when: ansible_pkg_mgr == "apt"
    
    roles:
    - init_enviroment
    - install_docker
    - install_kind
```

**The `hosts`** field specifies the target hosts for the playbook.

**The `gather_facts`** directive instructs Ansible to collect information about the hosts prior to executing tasks.

**The `become`** directive ensures Ansible commands run with elevated privileges (like root).

**In the `pre_tasks`** section, the EC2 instance is set up and necessary packages are installed.

**The `roles`** then specifies the sequence in which the environment is initialized, Docker is installed, and Kind is set up.

**Note**:

_**For successful playbook execution**_, ensure that all referenced roles (like `init_enviroment`, `install_docker`, and `install_kind`) are available in your playbook's roles directory.

## Contributions

**Your contributions to this playbook are highly valued. If you have any suggestions, improvements, or encounter issues, please don't hesitate to open a pull request or an issue in the repository.**