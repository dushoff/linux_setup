## Please install all available updates for your release before upgrading.

## Checking for a new Ubuntu release || Please install all available updates for your release before upgrading.

## Failed to fetch http://security.ubuntu.com/ubuntu/dists/focal-security/main/dep11/icons-64x64.tar  
## sudo rm -fr /var/lib/apt/lists/partial/ ##

ubu = `lsb_release -cs`

current: target
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

utils: latexdiff.apt rename.apt pdfgrep.apt pdftk.apt

## vpn

# vpn alias should already exist (use it for location guidance)
# Download latest tgz from internet
# go to vpn subdirectory (where license is) and sudo ./vpn_install<tab>
# Run vpn and type (first time) connect to sslvpn.mcmaster.ca

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

rubella: kdensity.cran

current: EpiEstim.cran ordinal.cran furrr.cran
agronah: truncnorm.cran BiocManager.cran truncdist.cran DESeq2.bioconductor here.cran metR.cran sn.cran

DESeq2.bioconductor: RCurl.cran

rabies: ggforce.cran

dataviz: huxtable.cran

######################################################################
## r updates and paths

R ?= /usr/bin/R
RREPO ?= http://lib.stat.cmu.edu/R/CRAN

updateR: 
	 echo 'update.packages(repos = "$(RREPO)", ask=FALSE, checkBuilt=TRUE)' | $(R) --vanilla

######################################################################

## R set up; set site-library to be world-writable to avoid different library paths. leave library alone (for core stuff)

## /usr/local/lib/R should not exist; it can confuse CMD INSTALL
## Why did it come back??? if it did 2022 Nov 16 (Wed)
## deleting from fiVe
## - sudo chmod a+w /usr/local/lib/R/site-library
## sudo rm -fr /usr/local/lib/R ##

Rlibcombine:
	sudo chmod -R a+wrX /usr/lib/R/site-library
	- mv /home/dushoff/R/x86_64-pc-linux-gnu-library/4.2/* /usr/lib/R/site-library
	@echo Combined!

######################################################################

Ignore += *.cran
%.cran:
	apt-get install -y ` echo r-cran-$* | tr '[:upper:]' '[:lower:]' ` && touch $@

## Hand-downcased; move around or check or something
## Started just editing here
oldrdefault: bbmle.cran bsts.cran Cairo.cran caret.cran cowplot.cran date.cran devtools.cran directlabels.cran effects.cran egg.cran emdbook.cran emmeans.cran epiestim.cran expss.cran factominer.cran ggdark.cran ggpubr.cran ggrepel.cran ggtext.cran ggthemes.cran glmmtmb.cran haven.cran kableextra.cran kdensity.cran latex2exp.cran lmperm.cran logitnorm.cran margins.cran matlib.cran memoise.cran openxlsx.cran performance.cran r2jags.cran remotes.cran rjags.cran rootsolve.cran rstan.cran splitstackshape.cran survivalroc.cran table1.cran tidyverse.cran tikzdevice.cran vgam.cran asymptor.cran rticles.cran
oldrcurrent: rmarkdown.cran sn.cran kdensity.cran

rubella: ggpmisc.cran
dataviz: GGally.cran
varpred: brms.cran rstanarm.cran patchwork.cran

macpan: pomp.cran Hmisc.cran DEoptim.cran deSolve.cran diagram.cran fastmatrix.cran semver.cran

bolton: varhandle.cran MLmetrics.cran

## r from source
## Default: dependencies=c("Depends", "Imports", "LinkingTo")
Ignore += *.rsource
%.rsource:
	 $(rsource_r)
rsource_r = echo 'install.packages("$*", repos = "$(RREPO)")' | $(R) --vanilla && touch $*.source

######################################################################

## R dependencies

## bugfix, or something 2022 Nov 06 (Sun) (email with park from Jan)
tikzDevice.rsource: cairo.cran

######################################################################

## bioconductor

Ignore += *.bioconductor
%.bioconductor: BiocManager.cran
	echo 'BiocManager::install("$*")' | $(R) --vanilla > $@

######################################################################

## Tex

texall: texlive.apt texlive-bibtex-extra.apt texlive-fonts-extra.apt texlive-humanities.apt texlive-latex-extra.apt texlive-science.apt texlive-publishers.apt texlive-extra-utils.apt texlive-xetex.apt biber.apt texinfo.apt

######################################################################

## pandoc [[investigate]]

## Use a resource directory for debs, bins, etc.

######################################################################

## Sound recorder

## kazam under random works OK, but only when display magnification is set to 1

######################################################################

## pdf PDF viewer
## evince is the default, but cannot open certain docs

## This acts really weird on the weird doc
gv.apt:

## This looks similar to evince
zathura.apt:

## wine and snap! Help!! Surprisingly bad even given expectation
acrordrdc.snap:

/home/dushoff/Downloads/adobe.deb:
	wget -O $@ ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb

acroread_prereqs: libxml2.i386 libcanberra-gtk-module.i386 gtk2-engines-murrine.i386 libatk-adaptor.i386 libgdk-pixbuf-xlib-2.0-0.i386 

acroread.deb: /home/dushoff/Downloads/adobe.deb acroread_prereqs

Ignore += *.deb
%.deb:
	sudo dpkg -i $< > $@

######################################################################

## manual chrome updates

chrome.manual: gdebi.apt dropstuff/chrome.deb.rmk chrome.debinstall

Ignore += dropstuff
dropstuff/chrome.deb: | dropstuff
	wget -O $@ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

%.debinstall: dropstuff/%.deb
	sudo gdebi $<

######################################################################

## Randomly adding stuff (when?)

random: pdftk-java.apt docker.apt gcalcli.apt dconf-editor.apt kazam.apt pip.apt python-is-python3.apt heif-gdk-pixbuf.apt

## HEIC pictures can be opened after heif… is installed. The first time, you may need to right click the picture and select Other Application/Image Viewer.

######################################################################

## Things added since 2022 Oct 05 (Wed)

newapt: gnome-screenshot.apt libjs-mathjax.apt audio-recorder.apt maxima.apt cups-pdf.apt

## https://askubuntu.com/questions/1403994/how-to-change-the-default-screenshot-folder-in-gnome-42

######################################################################

# lpr print to file

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

Ignore += i386.config
i386.config:
	sudo dpkg --add-architecture i386
	touch $@

Ignore += *.i386
%.i386: i386.config
	sudo apt-get install -y $*:i386 && touch $@

## Absolutely making this up! 2022 Sep 10 (Sat)
Ignore += *.pparepo
%.pparepo:
	sudo add-apt-repository ppa:$*/ppa

%.npm: npm.apt
	sudo npm install -g $*

Ignore += *.gem
%.gem:
	sudo gem install $*
	touch $@

## This does not work; I think it wants a local installation of ruby
%.ugem:
	gem install --user-install $*

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
