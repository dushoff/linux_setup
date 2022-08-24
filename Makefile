## This is linux_setup; a 2022 attempt to make my linux setup makier

## Checking for a new Ubuntu release || Please install all available updates for your release before upgrading.

current: random
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

## This doesn't work to ensure we are super because Makefile is always up-to-date
## Therefore, I added a whole bunch of sudo instead ... confused
Makefile:
	touch /bin/usr

######################################################################

## Upgrade 2022 Jun 05 (Sun)
## https://itsfoss.com/upgrade-ubuntu-version/

## Trying again late July

release:
	lsb_release -a

update:
	sudo apt update

upgrade: update
	sudo apt upgrade

dist-upgrade: upgrade
	sudo apt dist-upgrade

manage: update-manager-core.apt
	sudo update-manager -d

release-upgrade: dist-upgrade manage
	sudo do-release-upgrade

releaseR:
	sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
	$(MAKE) upgrade

R ?= /usr/bin/R
updateR: 
	 echo 'update.packages(repos = "$(REPO)", ask=FALSE, checkBuilt=TRUE)' | $(R) --vanilla > $@

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

random: pdftk-java.apt docker.apt gcalcli.apt

## Don't make this; use command from password file
## https://github.com/insanum/gcalcli
gcalcli.start:
	gcalcli --client-id=XXXXXX.apps.googleusercontent.com --client-secret=XXXXXX list

######################################################################

Ignore += *.apt
%.apt:
	sudo apt-get install -y $* && touch $@

######################################################################

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
