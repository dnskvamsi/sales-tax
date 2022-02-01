require_relative "./FileCreate"

class CSVFileWriter < FileCreator

    def write()
        fileobject=File.open("#{@file_name}"+".csv","a")
        for row in @data
                fileobject.write("#{row.join(",")}\n")
        end
        fileobject.close()
        return File.expand_path(File.dirname(__FILE__))
    end

end
