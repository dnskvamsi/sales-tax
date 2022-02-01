class FileCreator

    attr_accessor :data,:file_name

    def initialize(data,file_name)
        @data = data
        @file_name = file_name
    end

    def write()
        fileobject=File.open("#{@file_name}"+".txt","a")
        for row in @data
             fileobject.write("#{row.join("|")}\n")
        end
        fileobject.close()
        return File.expand_path(File.dirname(__FILE__))
    end
    
end