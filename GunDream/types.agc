
type coord3dT
	x as float
	y as float
	z as float
endtype

type componentT
	id as integer
	name as string
	pos as coord3dT
	rot as coord3dT
	sca as coord3dT
	model as string
	class as string
endtype

type MobileGraveT
	id as integer
	name as string
	pos as coord3dT
	rot as coord3dT
	sca as coord3dT
	model as string
	class as string
	comp as componentT[32]
endtype
