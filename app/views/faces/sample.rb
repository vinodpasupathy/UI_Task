.login_content {
    margin: 0 auto;
    padding: 25px 0 0;
    position: relative;
    text-align: center;
    text-shadow: 0 1px 0 #fff;
    min-width: 280px;
}




confirmation: "Password does not match"


routes.rb
resources :password_resets
get "reset_password/:id" => "users#reset_password"

UsersController

def reset_password
  @user = User.find_by_password_reset_token!(params[:id])
  if @user.password_reset_sent_at < 2.hours.ago
    redirect_to new_password_reset_path, alert: "Password reset has expired."
  elsif @user.update_attributes(params[:user])
    redirect_to root_url, notice: "Password has been reset!"
  else
    render :edit
  end
end

Actually the UsersController should be like this, the above is the update action, 
which should stay the same:ruby

  def reset_password
    @user = current_website.users.find_by_password_reset_token!(params[:id])
  end



 def login

    @admin=admin.new

    render :layout => false

 end

  def login_process

    params.permit!

    @admin=admin.where params[:id]

    if @admin.blank?

    session[:admin_id]=@admin.first.id

    redirect_to :action=>"browser"

    else

    redirect_to root_path

    flash[:notice] = "Your"
    end

 end

 def reset_password

    @admin = current_website.admin.find_by_password_reset_token!(params[:id])

 end


  def logout

      session[:product_id]=nil

      redirect_to root_path
  end

 def forgot

    @admin=admin.new

    render :layout => false

 end

 def forgot_process

  @admin=admin.new(admin_params)

   if @admin.save

   redirect_to :action=>"login"

   else

   render "new_account"

   end

 end

<%= link_to "Home",products_home_path%>

<div class="top">

<font color="gray"><h3><center>***LOGIN NOW***</center></h3></font>

<table align="center">

<%=form_for [@admin],:url=>{:controller=>"products",:action=>"login_process"} do |i| %>

<tr>

  <td><%= i.text_field :username,:placeholder=>"Username",:required=>true ,autofocus: true %></td>

</tr>

<tr>

  <td><%= i.password_field :newpass,:placeholder=>"Password",:required=>true,autocomplete: "off" %></td>

</tr>

<table align="center">

  <tr>

   <td><%= i.submit "Login"%></td>

   </tr>


  </center>

  <%end%>

</table>


<div>
<font color="gray"><h3><center>***CHENGE YOUR PASSWORD***</center></h3></font>

<table align="center">

<%=form_for [@admin],:url=>{:controller=>"products",:action=>"forgot_process"} do |i| %>

<tr>
  <td><%= i.text_field :username,:placeholder=>"Username",:required=>true %></td>
</tr>

<tr>
  <td><%= i.password_field :oldpass,:placeholder=>"OldPassword",:required=>true %></td>
</tr>

<tr>
  <td><%= i.password_field :newpass,:placeholder=>"NewPassword",:required=>true %></td>
</tr>

<table align="center">
  <tr>
    <td><%= i.submit "Submit"%></td>
  </tr>
</center>

<%end%>

</table>
~
get 'products/login'

  get 'products/login_process'


 <tr>
    <td><%= i.label :password_confirmation,"Password Confirmation"%></td>
     <td><%= i.password_field :password_confirmation, :value => params[:password],:require=>"true"%></td>
      </tr>
