.PHONY: all clean

PYTHON := python3
SHELL := bash

all: rms-supporters-haters-highlighter.user.css

rms-supporters:
	$(SHELL)  rms-supporters.sh

rms-haters:
	$(SHELL)  rms-haters.sh

sort-ppl: rms-supporters rms-haters
	$(PYTHON) sort-ppl.py

rms-supporters-haters-highlighter.user.css: sort-ppl
	$(PYTHON) user-css-gen.py

clean:
	rm -f rms-supporters-gh.txt rms-supporters-global.txt rms-supporters.txt \
		rms-haters-gh.txt rms-haters-global.txt rms-haters.txt \
		gigachads-gh.txt gigachads-global.txt \
		rms-supporters-haters-highlighter.user.css

clean-all: clean
# this is for support-letter repository deletion, but better to clone once and update than rm and clone again
	rm -rf rms-support-letter.github.io
# the potential self-caused error: message: API rate limit exceeded
# if you do this, the removal of github-api retrieved files, you risk getting blocked for some hours due to the already tightly used limit of data download you can use per IP 
	rm -rf api-supporters
	rm -rf api-haters
