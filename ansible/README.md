# Directory structure

```
ansible/
├── inventory
│   └── hosts             # Static IP inventory file
├── playbooks/
│   ├── site.yml          # Main playbook that calls others
│   ├── apache.yml        # Apache (Ubuntu) specific tasks
│   └── mariadb.yml       # MariaDB (RedHat) specific tasks
├── roles/
│   ├── apache/
│   │    ├── tasks/
│   │    │    └── main.yml
│   │    └── files/
│   │         └── index.html
│   ├── mariadb/
│   │    └── tasks/
│   │         └── main.yml
│   └── common/
│        └── tasks/
│             └── main.yml  # For common operations like update, upgrade
└── ansible.cfg            # Optional config file

```

# Ansible Playbook for Linux Server Setup

This directory contains Ansible playbooks and roles to manage a mixed fleet of Linux servers (Ubuntu and RedHat).

## Directory Structure

- `inventory/hosts`: Static inventory file listing target servers by IP and groups (e.g., ubuntu, redhat).
- `playbooks/site.yml`: Top-level playbook calling modular playbooks/roles for common setup, Apache on Ubuntu, and MariaDB on RedHat.
- `roles/`: Directory containing reusable roles for `common`, `apache`, and `mariadb`.
- `ansible.cfg`: Basic Ansible configuration file to set inventory and SSH options.

## Prerequisites

- Ansible installed locally (recommended version 2.10+).
- SSH access configured to all target servers using the preferred user defined in `ansible.cfg`.
- Target servers reachable on network with Python installed.

## Running the Playbook

1. Review and modify the `inventory/hosts` file to reflect your target servers' IP addresses. Group servers as `[ubuntu]` and `[redhat]` accordingly.

2. Verify or edit `ansible.cfg` to ensure the correct SSH user and inventory path.

3. Run the main playbook:

```
ansible-playbook -i inventory/hosts playbooks/site.yml

```

4. Ansible will:

- Update package repositories and upgrade installed packages on all hosts.
- Install and configure Apache webserver on Ubuntu servers with a simple "Hello world" page.
- Install and start MariaDB on RedHat servers.

## Customization

- Modify roles under `roles/` to change configurations or add new tasks.
- You can run individual playbooks for specific services if needed (e.g., `ansible-playbook playbooks/apache.yml`).

## Notes

- Host key checking is disabled in `ansible.cfg` for convenience—consider enabling it for production.
- Adjust the parallelism (`forks`) setting in `ansible.cfg` as per your system capacity.

---

Feel free to extend this setup for monitoring , or other software deployment tasks.
