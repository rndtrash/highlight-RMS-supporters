#!/usr/bin/env python3

import re

linkdict = dict()

####

print('Reading RMS supporters list...')

with open('rms-supporters.txt') as f:
	for l in f.read().splitlines():
		if l not in linkdict:
			linkdict[l] = 0
		linkdict[l] += 1

print('Done!')

####

print('Reading RMS haters list...')

with open('rms-haters.txt') as f:
	for l in f.read().splitlines():
		if l not in linkdict:
			linkdict[l] = 0
		linkdict[l] -= 1

print('Done!')

####

based = set()
cringe = set()
gigachads = set()

print('Making list of based/cringe/gigachads...')

for key in linkdict:
	val = linkdict[key]
	if val == 1:
		based.add(key)
	elif val == -1:
		cringe.add(key)
	else: # == 0
		gigachads.add(key)

print('Done!')

####

r_gh = re.compile(r'(http(s)?:\/\/)?(www\.)?github\.com\/(\w+)')

def match_github_handle(u):
	return r_gh.match(u)

def set_to_file(s, f_gh, f_global):
	for u in s:
		try_gh = match_github_handle(u)
		if try_gh != None and try_gh.group(4) != None:
			f_gh.write(try_gh.group(4) + '\n')
		else:
			f_global.write(u + '\n')

print('Writing lists to files...')

with open('rms-supporters-gh.txt', 'w') as f_gh, open('rms-supporters-global.txt', 'w') as f_global:
	set_to_file(based, f_gh, f_global)

with open('rms-haters-gh.txt', 'w') as f_gh, open('rms-haters-global.txt', 'w') as f_global:
	set_to_file(cringe, f_gh, f_global)

with open('gigachads-gh.txt', 'w') as f_gh, open('gigachads-global.txt', 'w') as f_global:
	set_to_file(gigachads, f_gh, f_global)

print('Done!')
