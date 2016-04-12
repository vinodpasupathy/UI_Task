require 'roo'
require 'spreadsheet'
require 'iconv'
require 'csv'
class Face < ActiveRecord::Base
  def self.com_vertical(file1,file2)
  t=0
   CSV.open("/home/altius/Documents/UI_Task/public/files/Vertical_Audit.csv","w") do |csv|
   csv << ["Item ID","Name","Value","Unit"]
   CSV.foreach(file1.tempfile,:encoding=>("ISO8859"))do |line|
        t=t+1
       next if t == 1
        x = line ; id=x.shift
        ad=[]
        ad=x.each_slice(3).to_a
        ad.each do|p|
       break if p[0] == nil
       unless p[1] == nil
        csv << [id] + p
       end
       end
       end
    end

   t=0
    CSV.open("/home/altius/mahesh/UI_Task/public/files/Vertical_Shipment.csv","w") do |csv|
    csv << ["Item ID","Name","Value","Unit"]
    CSV.foreach(file2.tempfile,:encoding=>("ISO8859"))do |line|
        t=t+1
       next if t == 1
        x = line ; id=x.shift
        ad=[]
        ad=x.each_slice(3).to_a
        ad.each do|p|
       break if p[0] == nil
       unless p[1] == nil
        csv << [id] + p
       end
       end
       end
   end
 end
   
 def self.comparison
  File.open("/home/altius/mahesh/UI_Task/public/files/Output_comparison.csv","w") do |c| 
  a=File.open("/home/altius/mahesh/UI_Task/public/files/Vertical_Audit.csv","r",:headers=>'true').collect{|o|o.chomp}
  b=File.open("/home/altius/mahesh/UI_Task/public/files/Vertical_Shipment.csv","r",:headers=>'true').collect{|o|o.chomp}
    if a != b
      c.puts b - a
    end
    end
 end
     
 def self.uoms(file1,file2)
  t=0
   CSV.open("/home/altius/mahesh/UI_Task/public/files/Vertical_UOM_Audit.csv","w") do |csv|
   csv << ["Item ID","Name","Value","Unit"]
   CSV.foreach(file1.tempfile,:encoding=>("ISO8859"))do |line|

       t=t+1
    next if t == 1
     x = line ; id=x.shift
     ad=[]
     ad=x.each_slice(3).to_a
     ad.each do|p|
    break if p[0] == nil
    unless p[1] == nil
     csv << [id] + p
    end
     end
     end
     end

      s=0
      t=0
      CSV.open("/home/altius/mahesh/UI_Task/public/files/UOM_file_Output.csv","w") do |csv|
      csv << ["Item ID","Name","Value","Unit"]
        a=CSV.read("/home/altius/mahesh/UI_Task/public/files/Vertical_UOM_Audit.csv")
        b=CSV.read(file2.tempfile)
         
          a.each do |i|
          t=t+1
q
            next if t==1
            if i[3]!=nil
                 b.each do |j|
                 s=j
            break if i[3]==s[0]
            end
            unless i[3]==s[0]
                 csv << i
            end
          end
        end
      end
  end
   
   def self.verticals(file1)
     
   CSV.open("#{Rails.root}/public/files/Vertical_Output.csv","w+") do |csv|
   csv << ["Item ID","Name","Value","Unit"]
   CSV.foreach(file1.tempfile,:encoding=>("ISO8859"))do |line|
   next if line[0].to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil
      
      x = line ; id=x.shift

      sd = x.shift(5) 

      sdd = sd.each_slice(1).to_a

      dd = ["HTML","PT Sourced PDF","RS Website","RSPDF","SKU Accounting Flag"] 

      ad = x.each_slice(3).to_a 

      add = dd,sd 

      ad1 = add.transpose 

      ad3 = ad1 + ad 

      ad3.each do|p|

    break if p[0] == nil
    unless p[1] == nil
      csv << [id] + p 
    end
    end
    end
    end
   end

=begin   def self.spell_check(file1)
    #  speller = FFI::Hunspell.dict('en_GB')
       f=File.open(file1.tempfile,"r").read
           f=f.split(" ").uniq!
       f.each do |i|
          next if i == i.upcase
          next if  i =~ /\d/
           i = i.strip
           i = i.gsub(/\W+/,' ')
           if speller.check?(i)

           else
              File.open("/home/altius/anand-ror/Firstop.csv","a+"){|file|file.puts("#{i}")}
           end
     end
            f=File.open("/home/altius/anand-ror/Firstop.csv","r").read
              f=f.split(" ").uniq!
               f.each do |i|
                 next if i == i.upcase
                   next if  i =~ /\d/
                     next if  i.length <= 2
                       i = i.strip
                         i = i.gsub(/\W+/,' ')
                 if speller.check?(i)

                  else
                    puts "#{i.chomp}"
               File.open("/home/altius/mahesh/UI_Task/public/files/Output_Spellcheck.csv","w+") do |c|
               c.puts("#{i}")
                 end
              end


   end
=end

def self.consecutive(file1,filename)
out=[]
f=File.open(file1.tempfile,"r").read
 File.open("/home/altius/mahesh/UI_Task/public/files/Output_#{filename}","w+")do|ss| #{|file|file.puts("#{f[k]+" "+f[k+1]}")}
f=f.split(" ")
#f  = f.gsub(/\W+/,'')
#next if  i =~ /\d/
i=(f.length)-1
i.times do |k|
     # f[k]= f[k].gsub(/\W+/,'')
      # f[k+1]= f[k+1].gsub(/\W+/,'')
     if f[k].downcase.gsub(/\W+/,'')==f[k+1].downcase.gsub(/\W+/,'')
    print " "
    print f[k]+" "+f[k+1]#,f[k+2]
   #  else
   #  puts false
#  file= File.open("/home/altius/mahesh/UI_Task/public/files/Consecutive_output.csv","a+")
   ss.puts  "#{f[k]+" "+f[k+1]+" "}"
 # file << "#{f[k]+" "+f[k+1]}"
    end
      end
   end
  end
def self.dups(file1)
 CSV.open("/home/altius/mahesh/UI_Task/public/files/Repetitive_output.csv", "w") do |csv|
   ff= CSV.read(file1.tempfile)
     @cc=ff.count
     ff.last(@cc-2).each do|i|
      if "#{i[2]}".include?("|")
       @c3="#{i[2]}".split("|")

        @c4= @c3.map{|i| i.strip}

        @c1=@c4.uniq.join("\n")


         @det =  [i[0]] + [i[1]] + [@c1]
       else
           @c="#{i[2]}".split("\n").uniq

           @i=@c.shift
            @ss=@c.map{|i| i.split(@i)}.uniq

           @c1=([@i]+[@ss]).join(" \n")
         @det =  [i[0]] + [i[1]] + [@c1]
       end

         csv << @det

     end
  end

end
=begin def self.reading_xl(file1,file2)
      
      b = Spreadsheet.open(file1.tempfile,"r")
   
    sheet=b.worksheet(0)
   
    file=File.open("/home/altius/mahesh/UI_Task/public/files/Audit_convert.csv","w")
      
    sheet.each do |i|
    if i != nil
      i="#{i}".gsub("nil", '')
      i= "#{i}".gsub!(/[^0-9A-Za-z,-,]/, '')
      file.puts "#{i}"
     
      end
    
     end
     b = Spreadsheet.open(file2.tempfile,"r")
   
    sheet=b.worksheet(0)
   
    file=File.open("/home/altius/mahesh/UI_Task/public/files/Ship_convert.csv","w")
      
    sheet.each do |i|
    if i != nil
      i="#{i}".gsub("nil", '')
      i= "#{i}".gsub!(/[^0-9A-Za-z,-,]/, '')
      file.puts "#{i}"
     
      end
    
     end
=end  end
  end
