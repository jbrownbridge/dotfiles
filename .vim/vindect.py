#    vindect.py
#    Copyright (C) 2001  Matthew Mueller <donut@azstarnet.com>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

"""vim-python script to detect indentation style and set syntax error and tabstops to match

Examines the current buffer and determines the indent style in use.
Then sets vim tabstop/shiftwidth/etc to work correctly with that style,
and creates a syntax match to highlight any indentation in the file that
does not match the selected style.

The default preferred indent and shiftwidth are 'tab' and 4, you may call
setDefaults to change this, or pass the preferred values to the detect 
function.

example setup:
  1) place this file in ~/.vim/

  2) in .vimrc add:
    let mysyntaxfile = "~/.vim/mysyntax.vim"
    if has("python")
      py import sys,os; sys.path.append(os.path.expanduser("~/.vim/"))
      py import vindect
      "if you want different defaults: py vindect.setDefaults(...)
    endif

  3) in ~/.vim/mysyntax.vim:
    if has("python")
      au Syntax python py vindect.detect() 
      au Syntax cpp py vindect.detect()
      au Syntax c py vindect.detect()
      au Syntax java py vindect.detect(preferred='space')
	  "...etc...
    endif

(See :help mysyntaxfile for detailed info)

Also note that if you have autocmd filetype matches elsewhere, in order to
avoid potential conflicts you may wish to remove any setting of tabstop,
shiftwidth, softtabstop, smarttab, or expandtab.  (Though you'll probably
want to keep the autocmd to set cindent/smartindent/etc appropriatly)

"""

__version__ = "1.0"

import vim, re, os

def setDefaults(indent=None, shiftwidth=None, maxlines=None, verbose=None):
	"""set default settings to use for detect()"""
	global _def_indent, _def_sw, _def_maxlines, _def_verbose
	if indent: _def_indent=indent
	if shiftwidth: _def_sw=shiftwidth
	if maxlines: _def_maxlines=maxlines
	if verbose: _def_verbose=verbose

setDefaults('tab', 4, 1000, 1)

def detect(preferred=None, preferredsw=None, force=None, forcesw=None, maxlines=None, dosyntax=1, dotabstop=1, verbose=None):
	"""detect the current buffer's indentation style and set syntax error and tabstops to match
	
	preferred -- type to use if can't detect or file is empty ('tab' or 'space' or 'mix')
		(mix aka smarttab mode in vim)
	preferredsw -- shiftwidth to use if can't detect, and always for tab indent style
	force -- if set, skip detection and use specified type
	forcesw -- if set, skip shiftwidth detection and use specified value
	maxlines -- maximum number of lines to scan when determining indent type and shiftwidth
	dosyntax -- set syn match for indenting that does not match the detected type
	dotabstop -- set tab and shift settings for the detected type
	verbose -- print detection info 0=none, 1=std, 2=extra
	"""
	b = vim.current.buffer
	if verbose>0: print 'vindect:',

	if not preferred: preferred = _def_indent
	if not preferredsw: preferredsw = _def_sw
	if not maxlines: maxlines = _def_maxlines
	if not verbose: verbose = _def_verbose

	if force:
		preferred = force
		ind_str = '()'
	else:
		mspcre= re.compile(' {1,7}\S')
		spcre = re.compile(' +\S')
		tabre = re.compile('\t+\S')
		mixre = re.compile('\t+ +\S')
		errre = re.compile('[ \t]+\S')
		mspc=spc=tab=mix=err=0
		
		for i in range(0, min(maxlines, len(b))):
			l = b[i]
			if spcre.match(l):   
				spc = spc+1
				if mspcre.match(l):	mspc = mspc+1
			elif tabre.match(l): tab = tab+1
			elif mixre.match(l): mix = mix+1
			elif errre.match(l): err = err+1

		def pref(n,name,p=preferred):
			#generate a tuple containing:
			# (number matching this type, is the preferred type?, the name of this type)
			return (n, p==name, name)
		preferred = max(pref(mix+mspc,'mix'), pref(spc,'space'), pref(tab,'tab'))[2]
		ind_str = '(s=%s, t=%s, m=%s(%+i), e=%s)'%(spc,tab,mix,mspc,err)

	if forcesw:
		preferredsw = forcesw
		sw_str = '(forced)'
	elif preferred == 'tab':
		#if indent type is tab, there is no inherent sw, we can use the preferred always.
		sw_str = '()'
	else:
		indents=[0]*513
		ire = re.compile('[ \t]+\S')
		prev = 0
		for i in range(0, min(maxlines, len(b))):
			l = b[i]
			cur = 0
			for c in l:
				if c == '\t': cur = (cur+8)/8 * 8
				elif c == ' ': cur = cur+1
				else:
					ind=abs(cur - prev)
					if ind: #don't count 0's since they just mean this line is the same indent as the previous.
						# XXX: should we also try to detect (and ignore) blank lines between lines of the same indent some how?
						# it doesn't seem to be a big enough number of them to worry...
						indents[ind]=indents[ind]+1
					break
			prev = cur
		def pref(n,v,p=preferredsw):
			#generate a tuple containing:
			# (number matching this sw, is the preferred sw?, the sw)
			return (n, p==v, v)
		maxpt = max(map(pref, indents, range(0, 513)))
		preferredsw = maxpt[2]
		if verbose>0:
			total = reduce(lambda x,y: x+y, indents)
			sw_str = '(%5.2f%%)'%(maxpt[0]/float(total)*100)
			if verbose>1:
				sw_str = sw_str+' '+`filter(lambda p: p[1]>0, map(None, range(0,513), indents))`

	vim.command('syn match indentError "fooo"') #create a silly thing so that the clear can't fail
	vim.command('syn clear indentError')

	if dosyntax and not vim.eval('&syntax'):
		print '(syntax not on)',
		dosyntax=0

	settings={
		'tab':  (r'"^\s* \+"',  'tabstop=%i'%preferredsw),# shiftround'),
		'mix':  (r'"^ \+\t\+"', 'smarttab'),
		'space':(r'"^\s*\t\+"', 'softtabstop=%i expandtab'%preferredsw),
	}[preferred]
	if dosyntax:
		vim.command('syn match indentError '+settings[0])
		vim.command('hi link indentError Error')
	if dotabstop:
		#set default values before hand.
		vim.command('set tabstop=8 shiftwidth=%s softtabstop=0 nosmarttab noexpandtab '%preferredsw + settings[1])

	#if verbose>0: print preferred, force and '(forced)' or '(s=%s, t=%s, m=%s(%+i), e=%s)'%(spc,tab,mix,mspc,err)
	if verbose>0: print preferred, ind_str, 'sw=%i'%preferredsw, sw_str
	return preferred

# todo:
#
# * make match work inside strings/comments too?
#
