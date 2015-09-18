"fix highligh italic accessibility with markdown files
syn region markdownItalic start="\S\@<=\*\|\*\S\@=" end="" keepend contains=markdownLineStart
syn region markdownItalic start="\S\@<=_\|_\S\@=" end="" keepend contains=markdownLineStart

