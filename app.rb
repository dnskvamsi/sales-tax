require_relative "./sales_tax_calculator"
require_relative "./InputDetails"

if $PROGRAM_NAME == __FILE__
    input=InputDetails.new()
    conversion_data=CoversionData.new("http://data.fixer.io/api/latest?access_key=93cae40df10b0521f99e1271a38794b9&base=EUR&symbols=INR,USD,EUR")
    Generate.new(input,conversion_data).data_generator()
end