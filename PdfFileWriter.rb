require_relative "./FileCreate"

class PdfFileWriter < FileCreator

    def write()
        fileobject=File.open("#{@file_name}"+".pdf","a")
        for row in @data
                fileobject.write("#{row.join("\t")}\n")
        end
        fileobject.close()
        return File.expand_path(File.dirname(__FILE__))
    end

end

# PdfFileWriter.new([["file"]],"filename",".pdf",",").write()