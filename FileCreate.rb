class FileCreator
    attr_accessor :data,:extension,:delimiter,:file_name
    def initialize(data,file_name,extension,delimiter)
        @data = data
        @extension = extension
        @delimiter = delimiter
        @file_name = file_name
    end
    def write()
        fileobject=File.open("#{@file_name}"+"#{@extension}","a")
        for row in @data
             fileobject.write("#{row.join(@delimiter)}\n")
        end
        fileobject.close()
        return File.expand_path(File.dirname(__FILE__))
    end
end