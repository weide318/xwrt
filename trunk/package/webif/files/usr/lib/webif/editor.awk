BEGIN {
	print "<form method=\"post\" action=\"" url "\" enctype=\"multipart/form-data\">"
	start_form("@TR<<File>>: " path "/" file)
	print hidden("path", path)
	print hidden("edit", file)
	printf "<textarea name=\"filecontent\" cols=\"80\" rows=\"20\">"
}

{
	gsub("&", "\\&amp;", $0)
	gsub("<", "\\&lt;", $0)
	gsub(">", "\\&gt;", $0)
	print $0
}

END {
	print "</textarea><br />"
	print button("save", "Save") "&nbsp;" button("cancel", "Cancel")
	end_form("&nbsp;")
	print "</form>"
}
