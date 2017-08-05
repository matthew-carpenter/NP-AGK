
function show_menu_main()
	// TODO: Main menu function
endfunction 1

function show_dev_hud()
	print(ScreenFPS())
	print("Run Mode: " + str(runmode))

	if GetInternetState() = 1
		netstate$ = "Ok"
	else
		netstate$ = "None"
	endif
	print("Network: " + netstate$)
endfunction

function make_http_connection(host as string,request as string)
	http = CreateHTTPConnection()
	SetHTTPTimeout(http,3000)
	SetHTTPHost(http,host,0)
	SendHTTPRequestASync(http,request)
	while( GetHTTPResponseReady(http) = 0)
		print("Waiting for response...")
		Sync()
	endwhile
	response$ = "Error"
	if GetHTTPResponseReady(http) > 0
		response$ = GetHTTPResponse(http)
	endif
	CloseHTTPConnection(http)
	DeleteHTTPConnection(http)
	testfile = OpenToWrite("httptest.txt",0)
	WriteString(testfile,response$)
endfunction response$
