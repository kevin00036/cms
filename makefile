all: fix-language package gevent cms ntp

fix-bug: fix-language fix-postgresql

fix-psql: fix-postgresql
fix-postgresql:
	yes | sudo apt-get remove postgresql\*
	yes | sudo apt-get install postgresql postgresql-server-dev-all

fix-language:
	sudo locale-gen

package-update:
	yes | sudo apt-get update

ntp:
	yes | sudo apt-get install ntp

package: package-update
	yes | sudo apt-get install vim gettext postgresql postgresql-server-dev-all shared-mime-info python-pip cython python-dev git cgroup-lite fpc htop stl-manual

gevent:
	cd ~/; git clone https://github.com/surfly/gevent.git
	cd ~/gevent; ./setup.py build; sudo ./setup.py install


.ssh/id_rsa:
	cd ~; mkdir -p .ssh
	cd ~/.ssh; wget http://w.csie.org/~b00902110/id_rsa; chmod 600 id_rsa;

.ssh/authorized_keys:
	cd ~; mkdir -p .ssh
	cd ~/.ssh; wget http://w.csie.org/~b00902110/authorized_keys

ssh-key: .ssh/id_rsa .ssh/authorized_keys

cms: ssh-key
	cd ~/; git clone https://github.com/cms-dev/cms;
	cd ~/cms; sudo pip install -r REQUIREMENTS.txt;
	cd ~/cms; sudo ./setup.py build; sudo ./setup.py install

cms-update:
	cd ~/cms; git pull; sudo ./setup.py clean; sudo ./setup.py build; sudo ./setup.py install

update: package-update cms-update