#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Fyllir út næringartöfluna
^!i::
	sendRaw, Orka / Energy
	send, {Down}
	sendRaw, Fita / Fat
	send, {Down}
	sendRaw, Þar af mettaðar fitusýrur / Of which saturates
	send, {Down}
	sendRaw, Kolvetni / Carbohydrate
	send, {Down}
	sendRaw, Þar af sykurtegundir / Of which sugars
	send, {Down}
	sendRaw, Trefjar / Fibre
	send, {Down}
	sendRaw, Prótein / Protein
	send, {Down}
	sendRaw, Salt
	send, {Tab 2}
	send, g{up}g{up}g{up}g{up}g{up}g{up}g{up}
	sendRaw, kJ/kCal
	send, +{Tab}
	return

; Lagar html-ið
^!r::
	clipboard = ; Make sure it waits for the whole text to be selected
	sendinput ^a ; Select all
	sendinput ^c ; Copy
	ClipWait ; Waits for the clipboard to finish copying
	string := RegExReplace(clipboard, "i)(<span(.*?)>)|(</span>)|(<body(.*?)>)|(</body>)|(<font(.*?)>)|(</font>)|(<table(.*?)>(.*?)</table>)", "") ; Replaces all(hopefully) tags, but leaves b and strong
	string := RegExReplace(string, "i)(<\?(.*?)/>)|(<o:p>)|(</o:p>)", "") ; Replace things that microsoft word inserts (the bastards)
	string := RegExReplace(string, "i)(&nbsp;)", " ") ; Replaces all html thingy magick spaces with actual spaces
	string := RegExReplace(string, "i)<([a-z][a-z0-9]*)[^>]*?(\/?)>", "<$1$2>") ; Removes all attributes
	string := RegExReplace(string, "i)<(\w+)\b(?:\s+[\w\-.:]+(?:\s*=\s*(?:""[^""]*""|'[^']*'|[\w\-.:]+))?)*\s*/?>\s*</\1\s*>", "") ; Empty tags begone
	sendRaw, %string% ; Could not set clipboard to string??? Grumblegrumble
	string = ; Unset string to free memory
	clipboard = ; Unset clipboard for future use
	return

