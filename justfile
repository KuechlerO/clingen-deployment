set positional-arguments

ping:
	ansible all -m ping -i hosts.yaml
play name:
	ansible-playbook -i hosts.yaml --vault-password-file .pass-ansible.txt {{name}}.yaml
