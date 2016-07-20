require 'csv'
class FacesController < ApplicationController
  def index
      @face=Face.all
  end
   def audit_report
      @face=Face.new
    end
    def audit_process 
      wu=[];f1=[];f2=[];f3=[];f4=[];f5=[];f6=[];f7=[];f8=[];f9=[];f10=[];f11=[];f12=[];file1=[];fmonth=[],anual=[];reporttyp=[]
    anual=params[:faces][:year]
    reporttyp=params[:faces][:reporttype]
    fmonth=params[:faces][:month]
    f1 << params[:faces][:aa]
    f2 << params[:faces][:bb]
    f3 << params[:faces][:cc]
    f4 << params[:faces][:dd]
    f5 << params[:faces][:ee]
    f6 << params[:faces][:ff]
    f7 << params[:faces][:gg]
    f8 << params[:faces][:hh]
    f9 << params[:faces][:ii]
    f10 << params[:faces][:jj]
    f11 << params[:faces][:kk]
    f12 << params[:faces][:ll]
    f1 << params[:faces][:a]
    f2 << params[:faces][:b]
    f3 << params[:faces][:c]
    f4 << params[:faces][:d]
    f5 << params[:faces][:e]
    f6 << params[:faces][:f]
    f7 << params[:faces][:g]
    f8 << params[:faces][:h]
    f9 << params[:faces][:i]
    f10 << params[:faces][:j]
    f11 << params[:faces][:k]
    f12 << params[:faces][:l]
    f1 << params[:faces][:aaa]
    f2 << params[:faces][:bbb]
    f3 << params[:faces][:ccc]
    f4 << params[:faces][:ddd]
    f5 << params[:faces][:eee]
    f6 << params[:faces][:fff]
    f7 << params[:faces][:ggg]
    f8 << params[:faces][:hhh]
    f9 << params[:faces][:iii]
    f10 << params[:faces][:jjj]
    f11 << params[:faces][:kkk]
    f12 << params[:faces][:lll]
    file1 = f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12
    @face=Face.audit_task(file1,fmonth,anual,reporttyp)
    if reporttyp=="Monthly"
    redirect_to "/files/#{fmonth}_#{anual}_audit_report.csv"
    else 
    redirect_to "/files/#{anual}_audit_report.csv"
    end
   end
  def duplication
    @dup=Face.new
  end
  def duplication_process
    file1=params[:face][:file_1]
    filename=params[:face][:file_1].original_filename
    if params[:face][:file_1].original_filename =~ /.\.csv$/i
    @dup=Face.dups(file1)
    redirect_to "/files/Repetitive_output.csv"
    else
    redirect_to faces_vert_help_path
    end

  end
  def vertical
   @face=Face.new
  end

  def vert_process
    file1=params[:face][:file_1]
    filename=params[:face][:file_1].original_filename
    if params[:face][:file_1].original_filename =~ /.\.csv$/i
    @face=Face.verticals(file1)
    redirect_to "/files/Vertical_Output.csv"
    else 
    redirect_to faces_vert_help_path
    end
  end
  def compare
      @face=Face.new
  end
  def save_file
   file1=params[:face][:file_1]
   file2=params[:face][:file_2]
   filename=params[:face][:file_1].original_filename
   filename=params[:face][:file_2].original_filename
    if params[:face][:file_1].original_filename =~ /.\.csv$/i and params[:face][:file_2].original_filename =~ /.\.csv$/i
      @face=Face.com_vertical(file1,file2)
      @face=Face.comparison
      redirect_to "/files/Output_comparison.csv"
    else
      redirect_to faces_vert_help_path
    end
  end

=begin  def spellcheck
    @face=Face.new
  end
 
 def spell_process
   if params[:face][:file_1].original_filename =~ /.\.csv$/i and params[:face][:file_2].original_filename =~ /.\.csv$/i
      file1=params[:face][:file_1]
      filename=params[:face][:file_1].original_filename
      @face=Face.spell_check(file1,)
      redirect_to :action=>"/process/Speller.rb"
   else
      redirect_to faces_vert_help_path
   end
  end
=end
  def uom
      @face=Face.new
  end

  def uom_method
    file1=params[:face][:file_1]
    file2=params[:face][:file_2]
    filename=params[:face][:file_1].original_filename
    filename=params[:face][:file_2].original_filename
    if params[:face][:file_1].original_filename =~ /.\.csv$/i and params[:face][:file_2].original_filename =~ /.\.csv$/i
       @face=Face.uoms(file1,file2)
       redirect_to "/files/UOM_file_Output.csv"
    else 
      redirect_to faces_vert_help_path
    end
  end

 def pilot
file1=params[:face][:file3]
      file2=params[:face][:file4]

      filename=params[:face][:file3].original_filename
      filename=params[:face][:file4].original_filename
     
      @face=Face.pil2(file1,file2)
    
      unless @face.blank?

      flash[:notice] = "Your file has been successfully imported."

      redirect_to "/files/output.csv"
   
      else

       flash[:notice] = "Invalid file headers or file format"
     
       redirect_to :action=> "welookup"
    
      end
end

def consicutive
  @face=Face.new
end

  def consicutive_process
 if params[:face][:file_1].original_filename =~ /.\.csv$/i 
      file1=params[:face][:file_1]
      filename=params[:face][:file_1].original_filename
      @face=Face.consecutive(file1,filename)
      redirect_to "/files/Output_#{filename}"
   else
      redirect_to faces_vert_help_path
   end
  end

  def vert_help
      @face=Face.all
  end

  def result
      @face=Face.new
  end

  def help_ver
      @face=Face.new
  end

  def help_uom
      @face=Face.new
  end

end
