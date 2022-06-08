## This is linux_setup

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

## Upgrade 2022 Jun 05 (Sun)
## https://itsfoss.com/upgrade-ubuntu-version/

release:
	lsb_release -a

update:
	sudo apt update

dist-upgrade: update
	sudo apt dist-upgrade

release-upgrade: update update-manager-core.apt
	sudo do-release-upgrade

## Ubuntu 22.04 There is no development version of an LTS available.
## Wait a couple of months

######################################################################

%.apt:
	apt-get install -y $* && touch $@

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

## -include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
