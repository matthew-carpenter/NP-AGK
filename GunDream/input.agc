
function handle_keyboard()
	handle_key_ESC()
endfunction

function handle_key_ESC()
	if GetRawKeyState(27)	`ESC key
		runmode = 0			`set the global variable 'runmode' to 'shutdown engine'
	endif
endfunction


