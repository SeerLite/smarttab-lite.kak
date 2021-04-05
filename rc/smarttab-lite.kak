provide-module smarttab-lite %{
	define-command -hidden smarttab-lite-check-0-0 nop

	hook global InsertChar '\t' %{
		try %{
			# Indent with tab
			"smarttab-lite-check-0-%opt{indentwidth}"
		} catch %{
			try %{
				execute-keys -draft <a-h> <a-k> '^\h*.\z' <ret>
				execute-keys -draft h %opt{indentwidth} @
			}
		}
	}

	hook global InsertDelete ' ' %{
		try %{
			try %{
				# Delete normally
				"smarttab-lite-check-0-%opt{indentwidth}"
			} catch %{
				execute-keys -draft <a-h> <a-k> '^ +.\z' <ret> I <space> <esc> <lt>
			}
		}
	}
}
