set positional-arguments

HOSTS := "hosts.yml"
PASSFILE := ".pass-ansible.txt"

ping:
	ansible all -m ping -i {{HOSTS}} --vault-password-file {{PASSFILE}}

play name:
	ansible-playbook -i {{HOSTS}} --vault-password-file {{PASSFILE}} {{name}}.yml

test name:
	./test-playbook {{name}}.yml

@vedit encfile:
	ansible-vault edit --vault-password-file {{PASSFILE}} {{encfile}}
@venc encfile:
	ansible-vault encrypt --vault-password-file {{PASSFILE}} {{encfile}}
@vdenc encfile:
	ansible-vault decrypt --vault-password-file {{PASSFILE}} {{encfile}}
