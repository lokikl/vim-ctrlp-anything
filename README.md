# vim-ctrlp-anything

The purpose of this is to fire CtrlP from the output content of a script. I use it to open the most recently rendered partial for my rails project.
And my script search for those partials from docker logs. This is a super powerful workflow and I like it a lot, immediately open a partial related to the current page you opened.


Usage
=====

Write your logic in a script in any language you want, and add line below in your project vimrc.

```
# e.g. nnoremap se :CtrlPanythingLocate <your script/command name><cr>
nnoremap se :CtrlPanythingLocate docker-logs-to-ctrlp.rb<cr>
```
