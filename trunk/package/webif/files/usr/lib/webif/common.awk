function start_form(title, field_opts, field_opts2) {
	print "<div class=\"settings\"" field_opts ">"
	if (title != "") print "<h3><strong>" title "</strong></h3>"
	print "<div class=\"settings-content\"" field_opts2 ">"
}

function end_form(form_help, form_help_link) {
	print "</div>"
	if (form_help != "") print "<blockquote class=\"settings-help\"><h3><strong>@TR<<Short help>>:</strong></h3>" form_help form_help_link "</blockquote>"
	print "<div class=\"clearfix\">&nbsp;</div></div>"
}

function textinput(name, value) {
	return "<input type=\"text\" name=\"" name "\" value=\"" value "\" />"
}

function textinput2(name, value, width) {
        return "<input type=\"text\" name=\"" name "\" value=\"" value "\" style=\"width:" width "em;\" />"
}
function hidden(name, value) {
	return "<input type=\"hidden\" name=\"" name "\" value=\"" value "\" />"
}

function button(name, caption) {
	return "<input type=\"submit\" name=\"" name "\" value=\"@TR<<" caption ">>\" />"
}

function helpitem(name) { 
	return "<dt>@TR<<" name ">>: </dt>"
}

function helptext(short, name) { 
	return "<dd>@TR<<" short "|" name ">>: </dd>"
}
function sel_option(name, caption, default, sel) {
	if (default == name) sel = " selected=\"selected\""
	else sel = ""
	return "<option value=\"" name "\"" sel ">@TR<<" caption ">></option>"
}
