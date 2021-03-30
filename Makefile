.PHONY: all clean

PYTHON := python3

all: rms-supporters-haters-highlighter.user.css

rms-supporters:
	$(PYTHON) rms-supporters.py

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
