require 'ffi/hunspell'
require 'csv'
module Spell_check
    def process
speller = FFI::Hunspell.dict('en_GB')
f=File.open(file1.tempfile,"r",:headers=>'true',"r").read
f=f.split(" ").uniq!
f.each do |i|
   next if i == i.upcase
  next if  i =~ /\d/

   i = i.strip
  i = i.gsub(/\W+/,' ')
  if speller.check?(i)
  else
  
     File.open("/home/altius/mahesh/rub.csv","a+"){|file|file.puts("#{i}")}
  end
end
f=File.open("/home/altius/mahesh/rub.csv","r").read
f=f.split(" ").uniq!
f.each do |i|
  next if i == i.upcase
 next if  i =~ /\d/
 next if  i.length <= 2
  i = i.strip
  i = i.gsub(/\W+/,' ')

 if speller.check?(i)
  else

     File.open("#{Rails.root}/publics/files/Output_#{filename}.csv","w+"){|file|file.puts("#{i}")}
  end
end
speller.close
end
end
