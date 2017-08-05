// show all errors
SetErrorMode(2)

// set up window
SetWindowTitle("GunDream")
SetWindowSize(1024,600,0)

// set up display
SetVirtualResolution(1024,600)
SetOrientationAllowed(1,1,1,1)
SetScissor(1,1,1,1)

SetClearColor(0,0,0)

SetSyncRate(30,0)						`ENGINE: 30 fps to save battery


UseNewDefaultFonts(1)					`ENGINE: default fonts
SetPrintSize(16)


SetCameraRange(1,15,1000)


// loading status
customimg=LoadImage("custom.png")
CreateText(1,"Loading Metro Theatre Scene")
SetTextFontImage(1,customimg)
SetTextAlignment(1,1)
SetTextPosition(1,50,45)
SetTextSize(1,10)
CreateText(2,"Artwork by Mark Blosser")
SetTextFontImage(2,customimg)
SetTextAlignment(2,1)
SetTextPosition(2,50,60)
SetTextSize(1,8)
Sync()


global runmode = 5
