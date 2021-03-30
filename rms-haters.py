#!/usr/bin/env python3

import httpx
from bs4 import BeautifulSoup

f = open("rms-haters.txt","w")

response = httpx.get('https://rms-open-letter.github.io/')

def find_github_username_end_index(string, start_index):
	i = start_index
	while i < len(string):
		if string[i] == ',' or string[i] == ')' or string[i] == ' ' or string[i] == '/' or string[i] == '\n':
			return i
		i += 1
	return None

def is_github_handle(tag):
	text = tag.getText()
	return (tag.name == 'li') and ('@' in text) and ('mailto' not in text) and ('http' not in text)

if response.status_code == 200:
	soup = BeautifulSoup(response.text, 'html.parser')
	for link in soup.select('ol li a'):
		l = link.get('href').rstrip('/#')
		if l != '':
			f.write(l + '\n')

	for text in soup.findAll(is_github_handle):
		raw_text = text.getText()
		github_username_start = raw_text.find('@')
		github_username_end = find_github_username_end_index(raw_text, github_username_start)
		ghnickname = raw_text[github_username_start + 1:github_username_end].rstrip('”').rstrip(';')
		if ghnickname != '':
			f.write('https://github.com/' + ghnickname + '\n')

f.close()
