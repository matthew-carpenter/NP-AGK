// Project: BoosterBlade
// Created: 2017-06-13

`show all errors
SetErrorMode(2)

`types
type gridT
	id as integer
	posX as integer
	posY as integer
	dimX as integer
	dimY as integer
	sizeX as integer
	sizeY as integer
endtype


button_grid as gridT
button_grid.id = 1
button_grid.posX = 64
button_grid.posY = 64
button_grid.dimX = 3
button_grid.dimY = 3
button_grid.sizeX = 32
button_grid.sizeY = 32



`set window
SetWindowTitle("BoosterBlade")
SetWindowSize(1024,600,1)
SetWindowAllowResize(1)
SetOrientationAllowed(1,1,1,1)


`set display
SetVirtualResolution(1024,600)
SetScissor(0,0,0,0)
SetClearColor(101,120,154)


`set environment
SetAmbientColor(128,128,128)
SetSunColor(255,255,255)
SetSkyBoxVisible(1)

SetFogMode(1)
SetFogColor(101,120,154)
SetFogRange(50,700)
SetFogSunColor(255,230,179)


// set camera
SetCameraPosition(1,0,75,-100)
SetCameraLookAt(1,0,37,0,0)

SetAmbientColor(128,128,128)


`performance VS beauty -------------------------------------
fsync_mode = 0
if fsync_mode = 0
	SetSyncRate(0,0)		`save battery and CPU/GPU cyles
else
	SetVSync(1)				`override SetSyncRate and set VSync to monitor refresh rate
endif

SetCameraRange(1,10,256)	`amount of geometry within viewport to render

UseNewDefaultFonts(1)		`(need to test) nicer default fonts

SetAntiAliasMode(0)			`(need to test) performance hit and visuals


// create lights
CreatePointLight(1,0,50,50,100,255,0,0)

// load soldier
SOLDIER = LoadObjectWithChildren("Original_Soldier.X")
	LoadImage(SOLDIER,"Soldier_body_1_D.png")
	SetObjectImage(SOLDIER,SOLDIER,0)

// texture gun
GUN = LoadImage("gun_D.png")
setobjectimage( GetObjectChildID(SOLDIER,2),GUN,0)

// hide fire spot object,
// (a cube that was added to the model to show the gun anchor point)
SetObjectVisible(GetObjectChildID(SOLDIER,1),0)

// add buttons
but_A_up = LoadImage("button_A_up.png")
but_A_dn = LoadImage("button_A_dn.png")
addvirtualbutton(1,32,524,32)
				: SetVirtualButtonVisible(1,1)
				: SetVirtualButtonImageUp(1,but_A_up)
				: SetVirtualButtonImageDown(1,but_A_dn)

but_B_up = LoadImage("button_B_up.png")
but_B_dn = LoadImage("button_B_dn.png")
addvirtualbutton(2,68,484,32)
				: SetVirtualButtonVisible(2,1)
				: SetVirtualButtonImageUp(2,but_B_up)
				: SetVirtualButtonImageDown(2,but_B_dn)

but_X_up = LoadImage("button_X_up.png")
but_X_dn = LoadImage("button_X_dn.png")
addvirtualbutton(3,0,484,32)
				: SetVirtualButtonVisible(3,1)
				: SetVirtualButtonImageUp(3,but_X_up)
				: SetVirtualButtonImageDown(3,but_X_dn)

but_Y_up = LoadImage("button_Y_up.png")
but_Y_dn = LoadImage("button_Y_dn.png")
addvirtualbutton(4,32,444,32)
				: SetVirtualButtonVisible(4,1)
				: SetVirtualButtonImageUp(4,but_Y_up)
				: SetVirtualButtonImageDown(4,but_Y_dn)

	//GetVirtualButtonExists
    //GetVirtualButtonPressed
    //GetVirtualButtonReleased
    //GetVirtualButtonState
    //SetButtonScreenPosition
    //SetVirtualButtonActive

    //SetVirtualButtonImageDown
    //SetVirtualButtonImageUp
    //SetVirtualButtonPosition
    //SetVirtualButtonSize



// play idle animation
PlayObjectAnimation(SOLDIER,"",1000,1282,1,0)
SetObjectAnimationSpeed(SOLDIER,20)

/*
// some other animations
PlayObjectAnimation( 1, "", 1000, 1282, 1, 0 )
PlayObjectAnimation( 1, "", 3744, 3828, 1, 0 )
PlayObjectAnimation( 1, "", 685, 707, 1, 0 )
PlayObjectAnimation( 1, "", 2160, 2216, 1, 0 )
*/

// get the bone that represents the head
// turn off animation on it so we can move it ourselves
headBone = GetObjectBoneByName( SOLDIER, "Bip01_Head" )
SetObjectBoneCanAnimate( SOLDIER, headBone, 0 )


// load terrain detail texture with mipmapping enabled
SetGenerateMipmaps(1)
TDETAIL = LoadImage("detail.png")
SetImageWrapU(TDETAIL,1)
SetImageWrapV(TDETAIL,1)


// load the terrain shader to give the terrain color based on height
LoadShader(1,"Terrain.vs","Terrain.ps")

// create the terrain object from a height map
TERRAIN = CreateObjectFromHeightMap("YellowStone.png",512,24,512,1,16)
SetObjectImage(TERRAIN,TDETAIL,0)
SetObjectUVScale(TERRAIN,0,128,128) // scale the detail texture so it repeats
SetObjectShader(TERRAIN,1)


speed# = 4


do
	debug_commands()

	// hold shift to move slower
	if ( GetRawKeyState(16) ) then speed# = 0.5

    // control the camera with WASD
    if GetRawKeyState(87) then MoveCameraLocalZ(1,speed#)
	if GetRawKeyState(83) then MoveCameraLocalZ(1,-speed#)
	if GetRawKeyState(65) then MoveCameraLocalX(1,-speed#)
	if GetRawKeyState(68) then MoveCameraLocalX(1,speed#)
	if GetRawKeyState(81) then MoveCameraLocalY(1,-speed#)
	if GetRawKeyState(69) then MoveCameraLocalY(1,speed#)

	if getvirtualbuttonstate(1) = 1 then MoveCameraLocalZ(1,speed#)
	if getvirtualbuttonstate(2) = 1 then MoveCameraLocalZ(1,-speed#)

	// play death animation, transition over 0.3 seconds
	if GetRawKeyPressed(32) or getvirtualbuttonpressed(3)
		SetObjectBoneCanAnimate( SOLDIER, headBone, 1 )
		PlayObjectAnimation( SOLDIER, "", 4971, 5021, 0, 0.3 )
	endif

	// if the death animation has stopped go back to original animation, transition over 0.5 seconds
	if GetObjectIsAnimating(SOLDIER) = 0
		SetObjectBoneCanAnimate( SOLDIER, headBone, 0 )
		PlayObjectAnimation( SOLDIER, "", 1000, 1282, 1, 0.5 )
	endif

	// rotate the camera
    if ( GetPointerPressed() )
        startx# = GetPointerX()
        starty# = GetPointerY()
        angx# = GetCameraAngleX(1)
        angy# = GetCameraAngleY(1)
        pressed = 1
    endif

    if ( GetPointerState() = 1 )
        fDiffX# = (GetPointerX() - startx#)/4.0
        fDiffY# = (GetPointerY() - starty#)/4.0

        newX# = angx# + fDiffY#
        if ( newX# > 89 ) then newX# = 89
        if ( newX# < -89 ) then newX# = -89
        SetCameraRotation( 1, newX#, angy# + fDiffX#, 0 )
    endif

    // rotate the head to always look at the camera
    // head is backwards on the bone so rotate the vector by 180 degrees
    bonex# = 2*GetObjectBoneWorldX( SOLDIER, headBone ) - GetCameraX(1)
    boney# = 2*GetObjectBoneWorldY( SOLDIER, headBone ) - GetCameraY(1)
    bonez# = 2*GetObjectBoneWorldZ( SOLDIER, headBone ) - GetCameraZ(1)
    setObjectBoneLookAt( SOLDIER, headBone, bonex#, boney#, bonez#, 0 )

    Sync()
loop


function debug_commands()
	if GetRawKeyState(27) then end	// exit on ESC key
	print("FPS: " + str(ScreenFPS()))
	print(GetRawLastKey())			// show last key pressed
endfunction


function position_button_grid(id,x,y,dimX,dimY,sizeX,sizeY,mode)
	ax = 32 : ay = 64
	bx = 64 : by = 32
	xx = 0  : xy = 32
	yx = 32 : yy = 0
endfunction
