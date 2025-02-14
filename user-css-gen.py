#!/usr/bin/env python3

import math

SPLIT_EVERY = 500

def make_css(text, color):
	return '{' + 'content: "{0}";display: inline-block;margin-left: 4px;padding: 0 7px;font-size: 12px;font-weight: 500;line-height: 18px;border-radius: 2em;border: 1px solid transparent;color: var(--color-pr-state-{1}-text);background-color: var(--color-pr-state-{1}-bg);border-color: var(--color-pr-state-{1}-border);'.format(text, color) + '}' # thx python

def add_entries_to_css(f, file, text, color):
	f.write('@-moz-document domain("github.com") {\n')
	with open(file + '-gh.txt') as f_gh:
		lines = f_gh.read().splitlines()
		# TODO: smells like shitcode
		for i in range(int(math.ceil(len(lines) / SPLIT_EVERY)) + 1): # Make new selector every 500 users
			lines_split = lines[i * SPLIT_EVERY:(i + 1) * SPLIT_EVERY]
			if len(lines_split) == 0:
				break
			first_entry = True
			for l in lines_split:
				if first_entry:
					first_entry = False
				else:
					f.write(',')
				f.write('a[href="/{}"]:after'.format(l)) # [data-hovercard-type="user"]
			f.write(make_css(text, color) + '\n')
	f.write('}\n')
	with open(file + '-global.txt') as f_global:
		lines = f_global.read().splitlines()
		for i in range(int(math.ceil(len(lines) / SPLIT_EVERY)) + 1):
			lines_split = lines[i * SPLIT_EVERY:(i + 1) * SPLIT_EVERY]
			if len(lines_split) == 0:
				break
			first_entry = True
			for l in lines_split:
				if first_entry:
					first_entry = False
				else:
					f.write(',')
				f.write('a[href="{}"]:after'.format(l))
			f.write(make_css(text, color) + '\n')

with open('rms-supporters-haters-highlighter.user.css', 'w') as f:
	f.write(
"""
/* ==UserStyle==
@name           RMS supporters/haters highlighter
@namespace      https://github.com/rndtrash/rms-supporters-haters-highlighter
@version        4.0.0
@description    nuff said
@author         rndtrash, tlani and frens :)
==/UserStyle== */
""" + '\n'
)
	f.write(':root{--color-pr-state-open-text: #57ab5a;--color-pr-state-open-bg: rgba(87,171,90,0.1);--color-pr-state-open-border: rgba(87,171,90,0.4);--color-pr-state-merged-text: #986ee2;--color-pr-state-merged-bg: rgba(176,131,240,0.1);--color-pr-state-merged-border: rgba(176,131,240,0.4);--color-pr-state-closed-text: #e5534b;--color-pr-state-closed-bg: rgba(201,60,55,0.1);--color-pr-state-closed-border: rgba(201,60,55,0.4);}\n')
	add_entries_to_css(f, 'rms-haters', 'Cringe', 'closed')
	add_entries_to_css(f, 'rms-supporters', 'Based!', 'open')
	add_entries_to_css(f, 'gigachads', 'GIGACHAD', 'merged')
