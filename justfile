set positional-arguments

ping:
	ansible all -m ping -i hosts.yaml
play name:
	ansible-playbook -i hosts.yaml -e @tokens.yaml --vault-password-file .pass-ansible.txt {{name}}.yaml
@vedit:
	ansible-vault edit --vault-password-file .pass-ansible.txt tokens.yaml
