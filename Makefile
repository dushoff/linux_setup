## This is linux_setup

current: random
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
## late July? Or try the weird laptop first?

######################################################################

## Use a resource directory for debs, bins, etc.

######################################################################

## manual chrome updates

chrome.manual: dropstuff/chrome.deb.rmk chrome.debinstall

Ignore += dropstuff
dropstuff/chrome.deb: | dropstuff
	wget -O $@ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

%.debinstall: dropstuff/%.deb
	sudo gdebi $<

######################################################################

## Randomly adding stuff

random: pdftk-java.apt

######################################################################

Ignore += *.apt
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
