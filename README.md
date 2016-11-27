# SublimeText_heredoc
patch to rollback the regression in syntax update for Ruby heredoc format

- original ST Packets repository: https://github.com/sublimehq/Packages
- sed -i.bak -e 's/\r$//g' something
- http://docs.sublimetext.info/en/latest/extensibility/packages.html#overriding-packages