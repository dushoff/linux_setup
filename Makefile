
## Checking for a new Ubuntu release || Please install all available updates for your release before upgrading.

ubu = `lsb_release -cs`

current: random
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Ignore += dump.txt

######################################################################

## New install 2022 Oct 22 (Sat)
## Freshening fiVe

## Start with git.apt, make.apt, screen.apt
## Clone dushoff/tech and make 
## linux_config and linux_setup
## make relink from linux_config

# Terminal
# * disable F10 (global) and F11 (shortcuts)
# * fonts (tango dark 22 for V; solarized light 22 for Te)

tcsh: tcsh.apt
	touch ~/.laliases

blocal.ubuntu:
	cd ~ && ln -fs .blocal.ubuntu ~/.blocal

## make a fake dropstuff to install before Dropbox
## Not fully tested
## DropResource = .
Ignore += linux_setup
chrome.manual:
## del dropstuff ##

## Run chrome and give it some time to register the extensions and find the passwords

## Run this in a separate terminal
startDropbox: nautilus-dropbox.apt
	dropbox start -i
## ls ~/Dropbox

## Get a new github token and put it in dump.txt
## Configure github
github.user:
	git config --global user.email "dushoff@mcmaster.ca"
	git config --global user.name "Jonathan Dushoff"
	git config --global pull.rebase false

ignore.config:

## make ~/screens 
## cd ~ && gcd screens

## make pullall a few times
## make use_ssh in the Bicko directory if that's still a thing

# xdotool.apt:

## make main.load from linux_config

textaid: coffeescript.npm text-aid-too.npm

## Reboot

## Sync and start real session

## Remember to page-ify things (DAIDD pages, notebook?)

## Change ghostscript to (read|write) /etc/ImageMagick-6/policy.xml
magick: imagemagick-6.q16.apt
	sudo gvim /etc/Im*/policy.xml

######################################################################

## Extras 2022 Oct 26 (Wed)

jekyll.gem: bundler.gem ruby-bundler.apt
ruby-bundler.apt: build-essential.apt ruby.apt ruby-dev.apt

######################################################################

## Upgrade 2022 Jun 05 (Sun)
## https://itsfoss.com/upgrade-ubuntu-version/

## Trying again late July

release:
	lsb_release -a

update:
	sudo apt-get update

upgrade: update
	sudo apt-get upgrade

## apt-get untested
dist-upgrade: upgrade
	sudo apt-get dist-upgrade

manage: update-manager-core.apt
	sudo update-manager -d

release-upgrade: dist-upgrade manage
	sudo do-release-upgrade

######################################################################

Ignore += rproject.add
rproject.add:
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
	sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(ubu)-cran40/"
	touch $@
	sudo apt update

rprog: rproject.add r-base-core.apt r-base-dev.apt

## r2u new hotness 2022 Oct 03 (Mon)
## https://github.com/eddelbuettel/r2u

r2u.update: /etc/apt/trusted.gpg.d/cranapt_key.asc /etc/apt/sources.list.d/cranapt.list
	sudo apt-get update

/etc/apt/trusted.gpg.d/cranapt_key.asc: wget.apt
	sudo wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc | sudo tee -a $@
/etc/apt/sources.list.d/cranapt.list: /etc/apt/trusted.gpg.d/cranapt_key.asc
	sudo echo "deb [arch=amd64] https://dirk.eddelbuettel.com/cranapt $(ubu) main" | sudo tee -a $@

######################################################################

Ignore += *.cran
%.cran: r-cran-%.apt
	$(move)

rdefault: bbmle.cran bsts.cran cairo.cran caret.cran cowplot.cran date.cran devtools.cran directlabels.cran effects.cran egg.cran emdbook.cran emmeans.cran epiestim.cran expss.cran factominer.cran ggdark.cran ggpubr.cran ggrepel.cran ggtext.cran ggthemes.cran glmmtmb.cran haven.cran kableextra.cran kdensity.cran latex2exp.cran lmperm.cran logitnorm.cran margins.cran matlib.cran memoise.cran openxlsx.cran performance.cran r2jags.cran remotes.cran rjags.cran rootsolve.cran rstan.cran splitstackshape.cran survivalroc.cran table1.cran tidyverse.cran tikzdevice.cran vgam.cran asymptor.cran rticles.cran

rcurrent: rmarkdown.cran sn.cran kdensity.cran

######################################################################

## r updates and paths

R ?= /usr/bin/R
RREPO ?= http://lib.stat.cmu.edu/R/CRAN

updateR: 
	 echo 'update.packages(repos = "$(RREPO)", ask=FALSE, checkBuilt=TRUE)' | $(R) --vanilla

######################################################################

## R set up; set site-library to be world-writable to avoid different library paths. leave library alone (for core stuff)

## /usr/local/lib/R should not exist; it can confuse CMD INSTALL

Rlibcombine:
	- sudo rmdir /usr/local/lib/R/site-library
	sudo chmod a+w /usr/lib/R/site-library
	mv /home/dushoff/R/x86_64-pc-linux-gnu-library/4.2/* /usr/lib/R/site-library

######################################################################

## Tex

texall: texlive.apt texlive-bibtex-extra.apt texlive-fonts-extra.apt texlive-humanities.apt texlive-latex-extra.apt texlive-science.apt texlive-publishers.apt texlive-extra-utils.apt texlive-xetex.apt biber.apt texinfo.apt

######################################################################

## pandoc [[investigate]]

## Use a resource directory for debs, bins, etc.

######################################################################

## Sound recorder

## manual chrome updates

chrome.manual: gdebi.apt dropstuff/chrome.deb.rmk chrome.debinstall

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

######################################################################

## Things added since 2022 Oct 05 (Wed)

newapt: gnome-screenshot.apt libjs-mathjax.apt

######################################################################

audio-recorder.apt: audio-recorder.pparepo

## 2022 Sep 10 (Sat) clean, don't install, after upgrade
totem.apt:
totem.clean: 
	$(RMR) ~/.cache/gstreamer-1.0

restrict: ubuntu-restricted-extras.aptrec ubuntu-restricted-addons.aptrec

## There is also bad, and ugly (worse) !
gstream: gstreamer1.0-plugins-good.apt gstreamer1.0-plugins-base.apt
## Working on docker setup
## snap vs install vs deb download
## install is probably best, but I just did snap on Te

## DON'T make this as root; it needs to know who you are
docker.groups:
	sudo usermod -aG docker ${USER} && newgrp docker

######################################################################

Ignore += *.apt
.PRECIOUS: %.apt
%.apt:
	sudo apt-get install -y $* && touch $@

Ignore += *.aptrec
%.aptrec: 
	sudo apt-get install --install-recommends  $* && touch $@

## Absolutely making this up! 2022 Sep 10 (Sat)
Ignore += *.pparepo
%.pparepo:
	sudo add-apt-repository ppa:$*/ppa

%.npm: npm.apt
	sudo npm install -g $*

## Not understanding yet. This is not working because it wants a local installation of ruby as well
%.ugem:
	gem install --user-install $*

%.gem:
	sudo gem install $*
	touch $@

## Avoid? 2022 Oct 23 (Sun)
## Is this what made the fiVe glitchy?
Ignore += *.snap
%.snap:
	sudo snap install $* && touch $@

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
