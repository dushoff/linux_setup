## Please install all available updates for your release before upgrading.

## Checking for a new Ubuntu release || Please install all available updates for your release before upgrading.

## Failed to fetch http://security.ubuntu.com/ubuntu/dists/focal-security/main/dep11/icons-64x64.tar  
## sudo rm -fr /var/lib/apt/lists/partial/ ##

## lsb_release -cs ##
ubu = `lsb_release -cs`

## long-term
ubul = jammy

pro:
	sudo pro attach C13uAy7aezsNGtHb5hT2vHp3wYgviJ
	sudo pro disable livepatch

current: upgrade
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

## siX 2023 Jul 16 (Sun)
## secure boot password: txRP0_113
## secure boot password: txRPO_113 ????
## Add third party but not update automatically
## update and reboot

# Terminal
# * disable F10 (general) and F11 (shortcuts, use backsapce)
# * fonts (tango dark 22 for V; solarized light 22 for Te)

## install git, make, screen, gdebi vim-gtk
## Use gdebi to install chrome (currently the only good way to connect with git).

## fn-esc to toggle function-key row

## Clone dushoff/tech and make 
## linux_config and linux_setup
## make relink from linux_config
## Make a tiny screen with these two manually

tcsh: tcsh.apt
	touch ~/.laliases

blocal.ubuntu:
	cd ~ && ln -fs .blocal.ubuntu ~/.blocal

Ignore += linux_setup

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

~/screens:
	ls screens || git clone https://github.com/dushoff/screens
	mv screens ~

## Do an hstore loop until credentials are saved
## make pullall a few times
## make use_ssh in the Bicko directory if that's still a thing

# xdotool.apt:

## make main.load from linux_config

textaid: coffeescript.npm text-aid-too.npm

## Sync and start real session

## Remember to page-ify things (DAIDD pages, notebook?)

## Change ghostscript none to (read|write) /etc/ImageMagick-6/policy.xml
magick: imagemagick-6.q16.apt
	sudo gvim /etc/Im*/policy.xml

######################################################################

## Extras 2022 Oct 26 (Wed)

jekyll.gem: bundler.gem ruby-bundler.apt
ruby-bundler.apt: build-essential.apt ruby.apt ruby-dev.apt

utils: latexdiff.apt rename.apt pdfgrep.apt pdftk.apt inkscape.apt

## pdfroff in bash asks for groff to be installed, but it can't be
## groff itself is here (provided by what package?)
confused: groff.apt

## fastmouse
## xkbset.apt:

## vpn

# vpn alias should already exist (use it for location guidance)
# Download latest tgz from internet
# go to vpn subdirectory (where license is) and sudo ./vpn_install<tab>
# Run vpn and type (first time) connect to sslvpn.mcmaster.ca

######################################################################

### 2023 Jul 16 (Sun)

weird_packages:
	sudo apt remove gjs gnome-remote-desktop libgjs0g

######################################################################

## Upgrade 2022 Jun 05 (Sun)
## https://itsfoss.com/upgrade-ubuntu-version/

## Trying again late July

release:
	lsb_release -a

update:
	sudo apt-get update

upgrade: update
	sudo apt-get -y upgrade
	sudo apt-get autoremove

## apt-get untested
dist-upgrade: upgrade
	sudo apt-get dist-upgrade

manage: update-manager.apt update-manager-core.apt
	sudo update-manager -d

release-upgrade: dist-upgrade manage
	sudo do-release-upgrade

release.all:
	sudo sed -i 's/Prompt=lts/Prompt=normal/g' /etc/update-manager/release-upgrades

## /etc/update-manager/release-upgrades

######################################################################

## Rutter ppa etc. seems superseded.
## https://cloud.r-project.org/bin/linux/ubuntu/#install-r
Ignore += rproject.add
rproject.add:
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
	## sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(ubu)-cran40/"
	sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/"
	touch $@
	sudo apt update

rprog: rproject.add r-base-core.apt r-base-dev.apt

## rstudio: download a deb from https://posit.co/download/rstudio-desktop/
## sudo gdebi ~/Downloads/rst*.deb ##
rstudio.deb:
	ls -t ~/Downloads/rst*.deb | head -1 | xargs -i sudo apt install -y '{}'

## apt-get not tested
pandoc.deb:
	ls -t ~/Downloads/pandoc*.deb | head -1 | xargs -i sudo apt-get install -y '{}'

## r2u new hotness 2022 Oct 03 (Mon)
## https://github.com/eddelbuettel/r2u

r2u.update: /etc/apt/trusted.gpg.d/cranapt_key.asc /etc/apt/sources.list.d/cranapt.list
	sudo apt-get update

Ignore += ubuntu_version wget-log
/etc/apt/trusted.gpg.d/cranapt_key.asc: wget.apt
	sudo wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc | sudo tee -a $@

## This did not work with an intermediate upgrade (non- LTS ubu)
/etc/apt/sources.list.d/cranapt.list: /etc/apt/trusted.gpg.d/cranapt_key.asc ubuntu_version
	sudo echo "deb [arch=amd64] https://dirk.eddelbuettel.com/cranapt $(ubu) main" | sudo tee -a $@

######################################################################

## r updates and paths

R ?= /usr/bin/R
RREPO ?= http://lib.stat.cmu.edu/R/CRAN

updateR: 
	 echo 'update.packages(repos = "$(RREPO)", ask=FALSE, checkBuilt=TRUE)' | $(R) --vanilla

## R set up; move everything to a single, world-writable site-library. leave library alone (for core stuff)
## the local/ version seems to keep coming back. I guess we keep merging it?
Rlibcombine:
	sudo chmod -R a+wrX /usr/lib/R/site-library
	- sudo chmod -R a+wrX /usr/local/lib/R/site-library
	- mv /usr/local/lib/R/site-library/* /home/dushoff/R/x86_64-pc-linux-gnu-library/4.2/* /usr/lib/R/site-library
	ln -s /usr/lib/R/site-library /usr/local/lib/R/site-library
	@echo Combined!

######################################################################

Ignore += *.cran
%.cran:
	sudo apt-get install -y ` echo r-cran-$* | tr '[:upper:]' '[:lower:]' ` && touch $@

rdefault: bbmle.cran bsts.cran cairo.cran caret.cran cowplot.cran date.cran devtools.cran directlabels.cran effects.cran egg.cran emdbook.cran emmeans.cran epiestim.cran expss.cran factominer.cran ggdark.cran ggpubr.cran ggrepel.cran ggtext.cran ggthemes.cran glmmtmb.cran haven.cran kableextra.cran kdensity.cran latex2exp.cran lmperm.cran logitnorm.cran margins.cran matlib.cran memoise.cran openxlsx.cran performance.cran r2jags.cran remotes.cran rjags.cran rootsolve.cran rstan.cran splitstackshape.cran survivalroc.cran table1.cran tidyverse.cran tikzdevice.cran vgam.cran asymptor.cran rticles.cran

bio1: ape.cran

rubella: kdensity.cran ggpmisc.cran

currentPack: EpiEstim.cran ordinal.cran furrr.cran bayesplot.cran

agronah: truncnorm.cran BiocManager.cran truncdist.cran DESeq2.bioconductor here.cran metR.cran sn.cran

roswell: RTMB.cran

DESeq2.bioconductor: RCurl.cran

rabies: ggforce.cran

dataviz: huxtable.cran GGally.cran
varpred: brms.cran rstanarm.cran patchwork.cran
qmee: mlmRev.cran DHARMa.rsource MCMCglmm.rsource coin.cran dotwhisker.rsource lmPerm.cran equatiomatic.rsource 
qmee_students: unmarked.cran randomForest.cran pacman.cran geomorph.cran

macpan: pomp.cran Hmisc.cran DEoptim.cran deSolve.cran diagram.cran fastmatrix.cran semver.cran doParallel.cran

undergraduate: ape.cran

bolton: varhandle.cran MLmetrics.cran

## r from source
## Default: dependencies=c("Depends", "Imports", "LinkingTo")
Ignore += *.rsource
%.rsource:
	 $(rsource_r)
rsource_r = echo 'install.packages("$*", repos = "$(RREPO)")' | sudo $(R) --vanilla && touch $*.rsource

######################################################################

## Stan hacking from Ben 2023 Aug 11 (Fri)

## Didn't work, but maybe go back to it

## install_github until the weird flag thing is fixed
## this is not currently helping, but I can't be bothered to find the standard way
cmdstanr.rgit: gituser=stan-dev

## Use cmdstanr to install cmdstan
Sources += cmdstan.R
cmdstan.Rout: cmdstan.R cmdstanr.rgit
	$(pipeR)

######################################################################

## Rethinking

rethinking@slim.rgit: gituser=rmcelreath
rethinking@slim.rgit: coda.cran mvtnorm.cran loo.cran dagitty.cran

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

## rgithub

Ignore += *.rgit

oor.rgit: gituser=canmod
macpan2.rgit: gituser=canmod
macpan2.rgit: gbranch=@refactorcpp

gforce = FALSE
%.rgit: | remotes.cran
	echo 'library(remotes); install_github("$(gituser)/$*$(gbranch)", force=$(gforce))' | sudo $(R) --vanilla && touch $@

glmnetpostsurv.rgit: gituser=cygubicko
satpred.rgit: gituser=cygubicko
satpred.rgit: gforce=TRUE
satpred.rgit: gbm.cran glmnetpostsurv.rgit pec.cran survivalmodels.cran

epigrowthfit.rgit: gituser=davidearn
epigrowthfit.rgit: gforce=TRUE

fitode.cran:

mp2: oor.rgit macpan2.rgit

datadrivencv.rgit: gituser=nstrayer

systemfonts.rgit: gituser=r-lib

d3scatter.rgit: gituser=jcheng5

shellpipes.rgit: gituser=dushoff

rRlinks.rgit: gituser=mac-theobio

ungeviz.rgit: gituser=wilkelab
colorblindr.rgit: gituser=clauswilke

streamgraph.rgit: gituser=hrbrmstr

cividis.rgit: gituser=marcosci

ggpubfigs.rgit: gituser=JLSteenwyk

ggstance.rgit: gituser=lionel-

######################################################################

ggplotFL.rsource: REPO = http://flr-project.org/R

######################################################################
## Work on modularizing

# Bolker packages
broom.mixed.rgit bbmle.rgit bio3ss3.rgit fitsir.rgit: gituser=bbolker

knitr.rgit: gituser=yihui

rmarkdown.rgit: gituser=rstudio

######################################################################

## There is apparently no elegant way to do this
ici3d-pkg.rgit: gituser=ICI3D
ici3d-pkg.rgit: gforce=TRUE

######################################################################

## Tex

texall: texlive.apt texlive-bibtex-extra.apt texlive-fonts-extra.apt texlive-humanities.apt texlive-latex-extra.apt texlive-science.apt texlive-publishers.apt texlive-extra-utils.apt texlive-xetex.apt biber.apt texinfo.apt latex-cjk-all.apt

######################################################################

## pandoc [[investigpandoc-citeproc.apt ate]]
## 2023 Jul 18 (Tue) pandoc-citeproc.apt is defunct; probably notes somewhere about what tc call
pandoc: pandoc.apt python3-pip.apt
python3-pip.apt: python-is-python3.apt 

%.pip: python3-pip.apt
	sudo pip install $*

## pandoc-xnos.pip: pandoc Does not work 2023 Jul 18 (Tue); come back to it I guess

# Bio.pip:

######################################################################

## Use a resource directory for debs, bins, etc.

######################################################################

## Sound recorder

## With screen capture
## kazam under random works OK, but only when display magnification is set to 1

######################################################################

## pdf PDF viewer
## evince is the default, but cannot open certain docs

## This acts really weird on the weird doc
gv.apt:

## This looks similar to evince
zathura.apt:

######################################################################

## Does okular allow us to get around some adobe reader problems?

## okular.apt:

## Avoid? 2022 Oct 23 (Sun)
## Is this what made the fiVe glitchy?
Ignore += *.snap
%.snap:
	sudo snap install $* && touch $@

## wine and snap! Help!! Surprisingly bad even given expectation
## see also adobe below -- but for how much longer?
acrordrdc.snap:

## julia.snap: some sort of tech issue here; install from tar

######################################################################

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
## rstudio.debinstall:

Ignore += dropstuff
dropstuff/chrome.deb: | dropstuff
	wget -O $@ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

## xdg-settings get default-web-browser 
## xdg-settings set default-web-browser google-chrome.desktop ##

## dropstuff/rstudio.deb

%.debinstall: dropstuff/%.deb
	sudo gdebi $<

######################################################################

## Randomly adding stuff (when?)

random: pdftk-java.apt docker.apt gcalcli.apt dconf-editor.apt kazam.apt heif-gdk-pixbuf.apt apt-file.apt perl-doc.apt

## HEIC pictures can be opened after heif… is installed. The first time, you may need to right click the picture and select Other Application/Image Viewer.

######################################################################

## Fonts

## Interactive: sudo apt install msttcorefonts

######################################################################

## Things added since 2022 Oct 05 (Wed)

newapt: gnome-screenshot.apt libjs-mathjax.apt maxima.apt cups-pdf.apt

## https://askubuntu.com/questions/1403994/how-to-change-the-default-screenshot-folder-in-gnome-42

thishaschanged: audio-recorder.apt 

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

######################################################################

## Chromecast

chromecast: chrome-gnome-shell.apt nodejs.apt npm.apt ffmpeg.apt

## https://extensions.gnome.org/extension/1544/cast-to-tv/

######################################################################

## Seafile
## REMOVED from siX in upgrade attempt

/usr/share/keyrings/seafile-keyring.asc:
	sudo wget -O $@ https://linux-clients.seafile.com/seafile.asc

## This tee command seems bizarre JD 2023 Sep 03 (Sun)
## sudo rm /etc/apt/sources.list.d/seafile.list /usr/share/keyrings/seafile-keyring.asc ##
/etc/apt/sources.list.d/seafile.list: /usr/share/keyrings/seafile-keyring.asc
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/seafile-keyring.asc] https://linux-clients.seafile.com/seafile-deb/$(ubul)/ stable main" | sudo tee $@ > /dev/null
	$(MAKE) update || (sudo $(RM) $@ && false)

Ignore += wget-log

seafile-gui.apt: seafile-cli.apt

seafile-cli.apt: /etc/apt/sources.list.d/seafile.list


######################################################################

## Sphinx dictation (disaster)

/home/dushoff/ve_pocketsphinx: python3.10-venv.apt
	python3 -m venv $@

pocketsphinx.install: /home/dushoff/ve_pocketsphinx
	. $</bin/activate
	cd $< && pip install .

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

-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
