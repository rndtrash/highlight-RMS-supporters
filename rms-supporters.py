#!/usr/bin/env python3

import httpx
from bs4 import BeautifulSoup

f = open("rms-supporters.txt","w")

response = httpx.get('https://rms-support-letter.github.io/')

if response.status_code == 200:
	soup = BeautifulSoup(response.text, 'html.parser')
	for link in soup.select('ol li a'):
		l = link.get('href').rstrip('/#')
		if l != '':
			#Prevents based Augusto from being too based
			if l.startswith('http://github.com/augustozanellato'):
				f.write('http://github.com/augustozanellato' + '\n')
				continue
			f.write(l + '\n')
f.close()
