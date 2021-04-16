.PHONY: all clean

PYTHON := python3
SHELL := bash

all: rms-supporters-haters-highlighter.user.css

rms-supporters:
	$(SHELL)  rms-supporters.sh

rms-haters:
	$(PYTHON) rms-haters.py

sort-ppl: rms-supporters rms-haters
	$(PYTHON) sort-ppl.py

rms-supporters-haters-highlighter.user.css: sort-ppl
	$(PYTHON) user-css-gen.py

clean:
	rm -f rms-supporters-gh.txt rms-supporters-global.txt rms-supporters.txt \
		rms-haters-gh.txt rms-haters-global.txt rms-haters.txt \
		gigachads-gh.txt gigachads-global.txt \
		rms-supporters-haters-highlighter.user.css
# enable for automatic support-letter repository deletion
#	rm -rf rms-support-letter.github.io
# error: message: API rate limit exceeded
# if you enable automatic github api files removal you risk getting blocked for some hours
	rm -rf api
