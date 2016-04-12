require 'csv'
#require 'ffi/hunspell'
class FacesController < ApplicationController
  def index
      @face=Face.all
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

  def spellcheck
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
