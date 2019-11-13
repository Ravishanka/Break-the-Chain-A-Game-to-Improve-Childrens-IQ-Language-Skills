
IO={}

function IO:new(obj)

	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self
	return obj
end


function IO:saveFile(filename,data)
		local theFile = filename
		local theValue = data
		local path = system.pathForFile( theFile, system.DocumentsDirectory )
		local file = io.open( path, "w+" )
		if file then
		   file:write( theValue )
		   io.close( file )
		end
end

function IO:readFile(fileName)
		local path = system.pathForFile( fileName, system.DocumentsDirectory )
        local file,err = io.open( path, "r" )
			if file then
			   local contents = file:read( "*n" )
			   io.close( file )
			   return  contents
			else
			   print(err)
			   file = io.open( path, "w" )
			   io.close( file )
			   return  0
			end
end
