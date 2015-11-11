if !has("python")
	echo "Error: Required vim compiled with +python"
endif

python << EOF

import vim
import zipfile
import shutil
import os
import gzip

#platform
if vim.eval('has("win32")') == "1":
	vim_path = vim.eval('$VIM')
	vimrc = '_vimrc'
	own_vimrc = '_zuohaitao.vim'
	root = 'C:\\'
	vimfiles_path = os.path.join(vim_path, 'vimfiles')
elif vim.eval('has("mac")') == "1":
	vim_path = vim.eval('$HOME')
	vimrc = '.vimrc'
	own_vimrc = '.zuohaitao.vim'
	root = '/'
	vimfiles_path = os.path.join(vim_path +'/.vim')
else:
	print 'unknow platform'
	raise Exception('Error', 'unknow platform')
print vimfiles_path
vim_run_time = vim.eval('$VIMRUNTIME')
#own vimrc
own_vimrc = os.path.join(vim_path, own_vimrc)
print own_vimrc
shutil.copyfile('zuohaitao.vim', own_vimrc)
if not os.path.exists(os.path.join(vim_path, vimrc)):
	with open(os.path.join(vim_path, vimrc), 'w') as f:
		f.write('"vimrc\n')

with open(os.path.join(vim_path, vimrc), 'r+') as f:
	lines = f.readlines()
	if len(lines) != 0:
		custom = 'source ' + own_vimrc
		if custom[:-1].lower() != lines[-1][:-1].lower():
			f.seek(0, 2)
			f.write(custom)
#save tmp files
tmp = os.path.join(root, 'tmp')
if not os.path.exists(tmp):
	os.mkdir(tmp)
#save undo files
undo = os.path.join(root, 'undo')
if not os.path.exists(undo):
	os.mkdir(undo)

#delete lang directory for fix bug
#the bug happens in windows os.
#when 'set encoding=utf8', chinese in menu bar is garbled.
if vim.eval('has("win32")') == "1":
	lang = os.path.join(vim_run_time, 'lang')
	if os.path.exists(lang):
		shutil.rmtree(lang)

#fix the accessibility of the highlighted italic in markdown files
after_syntax = os.path.join(os.path.join(vimfiles_path, 'after'),'syntax')
if not os.path.exists(after_syntax):
	print after_syntax
	os.makedirs(after_syntax)
shutil.copyfile('markdown.vim', os.path.join(after_syntax, 'markdown.vim'))


# install plugins by name from 'A' to 'Z'
plugin = os.path.join(vimfiles_path, 'plugin')
if not os.path.exists(plugin):
	print plugin
	os.makedirs(plugin)
# A ########
shutil.copyfile('a.vim', os.path.join(plugin, 'a.vim'))

# C ########
#ctags.exe
# becuase of $VIMRUNTIME is in the path envirment variable
# you can run ctag.exe with '!ctags.exe'
if vim.eval('has("win32")') == "1":
	shutil.copyfile('ctags.exe', os.path.join(vim_run_time, 'ctags.exe'))

#ctrlp
with zipfile.ZipFile('ctrlp.zip') as z:
	z.extractall(vimfiles_path)
	z.close()

# D ########
#DrawIt
with gzip.open('DrawItvba.gz') as gz:
	with open('DrawIt.vba', 'wb') as vba:
		vba.write(gz.read())
		vba.close()
	gz.close()
	vim.command('e DrawIt.vba')
	vim.command('source %')
	vim.command('e init.vim')
	os.remove('DrawIt.vba')

# M ########
#matrix
shutil.copyfile('matrix.vim', os.path.join(plugin, 'matrix.vim'))


# P ########
#pydiction-1.2.1
with zipfile.ZipFile('pydiction-1.2.1.zip') as z:
	with zipfile.ZipFile('pydiction.zip', 'w') as t:
		for i in z.namelist():
			name = i.replace('pydiction-1.2.1', '')
			if name[:-len('README.md')] == 'README.md' or name[:-len('README')] == 'README':
				continue
			b = z.read(i)
			t.writestr(name, b)
		t.close()
	z.close()
with zipfile.ZipFile('pydiction.zip') as t:
	t.extractall(vimfiles_path)
	t.close()
	z.close()
os.remove('pydiction.zip')

# S ########
#snipMate
with zipfile.ZipFile('snipMate.zip') as z:
	z.extractall(vimfiles_path)
	z.close()

# T ########
#tagbar
with zipfile.ZipFile('tagbar.zip') as z:
	z.extractall(vimfiles_path)
	z.close()
#tetris
shutil.copyfile('tetris.vim', os.path.join(plugin, 'tetris.vim'))

# P ########
#powerline
with zipfile.ZipFile('vim-powerline-develop.zip') as z:
	with zipfile.ZipFile('vim-powerline.zip', 'w') as t:
		for i in z.namelist():
			name = i.replace('vim-powerline-develop', '')
			if name[:-len('.gitignore')]  == '.gitignore' or name[:-len('README.rst')] == 'README.rst':
				continue
			b = z.read(i)
			t.writestr(name, b)
		t.close()
	z.close()
with zipfile.ZipFile('vim-powerline.zip') as t:
	t.extractall(vimfiles_path)
	t.close()
os.remove('vim-powerline.zip')

# V ########
#visualmark
shutil.copyfile('visualmark.vim', os.path.join(plugin, 'visualmark.vim'))



#make manual
vim.command('helptags $VIMRUNTIME/doc')
helptags_cmd = 'helptags '+ os.path.join(vimfiles_path, 'doc')
vim.command(helptags_cmd)
vim.command('helptags $VIMRUNTIME/doc')
vim.command('set noreadonly')


print 'successful'

EOF
