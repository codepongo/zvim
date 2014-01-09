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
	vim_path = vim.eval('$VIM')+os.sep
	vimrc = '_vimrc'
	own_vimrc = '_zuohaitao.vim'
	root = 'C:\\'
	vimfiles_path = vim_path + 'vimfiles' + os.sep
elif vim.eval('has("mac")') == "1":
	vim_path = vim.eval('$HOME')+os.sep
	vimrc = '.vimrc'
	own_vimrc = '.zuohaitao.vim'
	root = '/'
	vimfiles_path = vim_path +'.vim'+os.sep
else:
	print 'unknow platform'
	raise Exception('Error', 'unknow platform')
#own vimrc
shutil.copyfile('zuohaitao.vim', vim_path+own_vimrc)
with open(vim_path+vimrc, 'r+') as f:
	custom = 'source '+vim_path+own_vimrc
	if custom.lower() != f.readlines()[-1][:-1].lower():
		f.seek(0, 2)
		f.write('source '+vim_path+own_vimrc)
	f.close()	
if vim.eval('has("win32")') == 1:
	shutil.copyfile(own_vimrc, vim_path+own_vimrc)
#save tmp files
if not os.path.exists(root+'tmp'):
	os.mkdir(root+'tmp')
#save undo files
if not os.path.exists(root+'undo'):
	os.mkdir(root+'undo')

#delete lang directory for fix bug
#the bug happens in windows os.
#when 'set encoding=utf8', chinese in menu bar is garbled.
if vim.eval('has("win32")') == "1":
	lang = vim.eval('$VIMRUNTIME')+os.sep+'lang'
	if os.path.exists(lang):
		shutil.rmtree(vim.eval('$VIMRUNTIME')+os.sep+'lang')


# install plugins by name from 'A' to 'Z'

# C ########
#ctags.exe
# becuase of $VIMRUNTIME is in the path envirment variable
# you can run ctag.exe with '!ctags.exe'
if vim.eval('has("win32")') == "1":
	shutil.copyfile('ctags.exe', vim.eval('$VIMRUNTIME')+os.sep+'ctags.exe')

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
shutil.copyfile('matrix.vim', vimfiles_path+os.sep+'plugin'+os.sep+'matrix.vim')

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
shutil.copyfile('tetris.vim', vimfiles_path+os.sep+'plugin'+os.sep+'tetris.vim')

# P ########
#powerline
with zipfile.ZipFile('vim-powerline-develop.zip') as z:
	with zipfile.ZipFile('vim-powerline.zip', 'w') as t:
		for i in z.namelist():
			name = i.replace('vim-powerline-develop', '')
			if  name[:-len('.gitignore')]  == '.gitignore' or name[:-len('README.rst')] == 'README.rst':
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
shutil.copyfile('visualmark.vim', vimfiles_path+os.sep+'plugin'+os.sep+'visualmark.vim')




vim.command('helptags $VIMRUNTIME/doc')
helptags_cmd = 'helptags ' + vimfiles_path + os.sep + 'doc'
vim.command(helptags_cmd)
vim.command('helptags $VIMRUNTIME/doc')
vim.command('set noreadonly')


print 'successful'

EOF
