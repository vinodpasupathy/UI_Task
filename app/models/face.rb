require 'roo'
require 'spreadsheet'
require 'iconv'
require 'csv'
class Face < ActiveRecord::Base
  def self.com_vertical(file1,file2)
  t=0
   CSV.open("#{Rails.root}/public/files/Vertical_Audit.csv","w") do |csv|
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
    CSV.open("#{Rails.root}/public/files/Vertical_Shipment.csv","w") do |csv|
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
 def self.audit_task(file1,fmonth,anual,reporttyp)
  if reporttyp=="Monthly"
  tns=[]
  name=[]
  n=1;t=0;
  a=[];b=[];c=[];d=[];e=[];g=[];quality=[];final=[];a3=[];first=[];
  name1=[];a1=[];a2=[];totsq=[];totsa=[];totsater=[];err=[];qual=[];totsqu=[];totsam=[];qualper=[];errper=[];errp=[];qualp=[];toterr=[];toter=[];final=[]
  totsqur=[];totsamr=[];toterrr=[],totpr=[];totp=[]
  CSV.open("#{Rails.root}/public/out/outpro.csv" ,"w") do |csv|
  csv << ["Name","Projectnames","Total sku","Sample count","FinalErrorCount","Error(%)","Quality(%)"]
    file1.each do|kfile|
     unless kfile[0] == nil
      if kfile[1]==""
        ff=CSV.read(kfile[0].tempfile)
        ff.each_with_index do |row ,i| 
          next if i==0
          csv << [row[0],row[1].to_f,row[2].to_f,row[3].to_f]
        end
      else
        wui=kfile[n].to_f
        projectname=kfile[2]   
        ff=CSV.read(kfile[0].tempfile)
        ff.shift
        name=ff.collect{|row| row[1]}.uniq

           name.each do |i|
            @tns=ff.select{|row| i==row[1]}
            ff.each do|row|
              if i==row[1] && row[2] != nil
                c << row [2]
                next if row[3] == nil || row[3] == "NOTA" || row[8] == "Updated/Not Uptated" || row[8] == "Not Updated" 
                e << row[8]
              end
                 b=@tns.length
                 g=e.length
                 d=c.length
                 a=g.to_f/d.to_f*100.0
                 quality=100.0-a.to_f
                if wui ==7  
                  b=@tns.length
                  g=e.length
                  d=c.length
                  a=(g.to_f/d.to_f*100.0).round(2)
                  quality=(100.0-a.to_f).round(2)
                else
                  b=(wui/7*b).round(2)
                  d=(wui/7*d).round(2)
                  g=g
                  a=(g.to_f/d.to_f*100.0).round(2)
                  quality=(100.0-a.to_f).round(2)
                end
            end
              c.clear
              e.clear
              csv << [i,projectname,b,d,g,a,quality]
          end
      end    
    end
  end
end

    CSV.open("#{Rails.root}/public/files/#{fmonth}_#{anual}_audit_report.csv" ,"w") do |final|
    final << ["Name","ProjectNames","Total sku","Sample count","FinalErrorCount","Error(%)","Quality(%)"]    
    z=CSV.read("#{Rails.root}/public/out/outpro.csv")
      a1=z.collect{|s| s[0]}.uniq
       a1.each_with_index do |p,index|
          next if index == 0
            z.each do |s|
              if p==s[0]
                totp << s[1]
                totsq << s[2].to_f
                totsa << s[3].to_f
                toter << s[4].to_f
                err << s[5].to_f
                qual << s[6].to_f
              end
                totsqu = totsq.inject(:+)
                totsam = totsa.inject(:+)
                toterr = toter.inject(:+)
                totsqur = (totsqu.to_f).round(2)
                totsamr = (totsam.to_f).round(2)
                toterrr = (toterr.to_f).round(2)
                qualp = qual.inject(:+)
                errp = err.inject(:+)
                errper = (toterr.to_f/totsam.to_f*100.0).round(2)
                qualper = (100-errper).round(2)
                totpr=totp.uniq.to_s.gsub!(/[^0-9A-Za-z,-,]/, '')
            end
              totsq.clear
              totsa.clear
              toter.clear
              err.clear
              qual.clear
              totp.clear
              final << [p,totpr,totsqur,totsamr,toterrr,errper,qualper]
        end
        
   end
else
  tns=[]
  name=[]
  n=1;t=0;
  a=[];b=[];c=[];d=[];e=[];g=[];quality=[];final=[];a3=[];first=[];
  name1=[];a1=[];a2=[];totsq=[];totsa=[];totsater=[];err=[];qual=[];totsqu=[];totsam=[];qualper=[];errper=[];errp=[];qualp=[];toterr=[];toter=[];final=[]
  totsqur=[];totsamr=[];toterrr=[],totpr=[];totp=[]
  CSV.open("#{Rails.root}/public/out/outpro.csv" ,"w") do |csv|
  csv << ["Name","Projectnames","Total sku","Sample count","FinalErrorCount","Error(%)","Quality(%)"]
    file1.each do|kfile|
     unless kfile[0] == nil
        ff=CSV.read(kfile[0].tempfile)
        ff.each_with_index do |row ,i| 
          next if i==0
          csv << [row[0],row[1],row[2].to_f,row[3].to_f,row[4]]
        end    
    end
  end
end
    CSV.open("#{Rails.root}/public/files/#{anual}_audit_report.csv" ,"w") do |final|
    final << ["Name","ProjectNames","Total sku","Sample count","FinalErrorCount","Error(%)","Quality(%)"]    
    z=CSV.read("#{Rails.root}/public/out/outpro.csv")
      a1=z.collect{|s| s[0]}.uniq

       a1.each_with_index do |p,index|
          next if index == 0
            z.each do |s|
              if p==s[0]
                totp << s[1]
                totsq << s[2].to_f
                totsa << s[3].to_f
                toter << s[4].to_f
                err << s[5].to_f
                qual << s[6].to_f
              end
                totsqu = totsq.inject(:+)
                totsam = totsa.inject(:+)
                toterr = toter.inject(:+)
                totsqur = (totsqu.to_f).round(2)
                totsamr = (totsam.to_f).round(2)
                toterrr = (toterr.to_f).round(2)
                qualp = qual.inject(:+)
                errp = err.inject(:+)
                errper = (toterr.to_f/totsam.to_f*100.0).round(2)
                qualper = (100-errper).round(2)
                totpr=totp.uniq.to_s.gsub(/\W/,'')
              end
              totsq.clear
              totsa.clear
              toter.clear
              err.clear
              qual.clear
              totp.clear
              final << [p,totpr,totsqur,totsamr,toterrr,errper,qualper]
        end
   end
end
end    
 def self.comparison
  File.open("#{Rails.root}/public/files/Output_comparison.csv","w") do |c| 
  a=File.open("#{Rails.root}/public/files/Vertical_Audit.csv","r",:headers=>'true').collect{|o|o.chomp}
  b=File.open("#{Rails.root}/public/files/Vertical_Shipment.csv","r",:headers=>'true').collect{|o|o.chomp}
    if a != b
      c.puts b - a
    end
    end
 end
     
 def self.uoms(file1,file2)
  t=0
   CSV.open("#{Rails.root}/public/files/Vertical_UOM_Audit.csv","w") do |csv|
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
      CSV.open("#{Rails.root}/public/files/UOM_file_Output.csv","w") do |csv|
      csv << ["Item ID","Name","Value","Unit"]
        a=CSV.read("#{Rails.root}/public/files/Vertical_UOM_Audit.csv")
        b=CSV.read(file2.tempfile)
         
          a.each do |i|
          t=t+1
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
   CSV.foreach(file1.tempfile,:encoding => 'iso-8859-1:utf-8')do |line|
   next if line[0].to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil
      
      x = line ; id=x.shift

      sd = x.shift(5) 

      sdd = sd.each_slice(1).to_a

      dd = ["HTML","PT Sourced PDF","RS Website","RSPDF","SKU Accounting Flag"] 

      ad = x.each_slice(3).to_a 

      add = dd,sd 

      ad1 = add.reduce(&:zip).map(&:flatten) 

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
 File.open("#{Rails.root}/public/files/Output_#{filename}","w+")do|ss| #{|file|file.puts("#{f[k]+" "+f[k+1]}")}
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
 CSV.open("#{Rails.root}/public/files/Repetitive_output.csv", "w") do |csv|
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
