## quarto.ideb: cloud/quarto.deb
%.ideb: $(wildcard ~/Downloads/*.deb)
	ls -t $^ | head -1 | xargs -i sudo apt-get install -y '{}'

## Not tested
Ignore += *.gdeb
%.gdeb: $(wildcard ~/Downloads/*.deb)
	ls -t $^ | head -1 | xargs -i sudo gdebi '{}'

## sudo gdebi ~/Downloads/rst*.deb ##
Ignore += *.deb
rstudio.deb:
	ls -t ~/Downloads/rst*.deb | head -1 | xargs -i sudo apt install -y '{}'

## apt-get not tested
pandoc.deb:
	ls -t ~/Downloads/pandoc*.deb | head -1 | xargs -i sudo apt-get install -y '{}'

## 2025 Apr 29 (Tue) Got rid of some google-chrome and linux_signing_key rules. 
## I'm using the below instead of the old apt approach to chrome
## signing key is kind of an orphan

## del linux_signing_key.pub ##
Ignore += linux_signing_key.pub
linux_signing_key.pub:
	wget -q -O $@ https://dl-ssl.google.com/linux/linux_signing_key.pub
	sudo install -D -o root -g root -m 644 $@ /etc/apt/keyrings/$@
