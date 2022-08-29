class SessionsController < ApplicationController
  def new
  end
  
  def create
    #user = User.find_by(email: params[:session][:email])
    #user = User.find_by(email_params)  #ストロングパラメーターに変更
    user = User.find_by(user_params[:email]) #ストロングパラメーターを一つに集約
    #if user && user.authenticate(params[:session][:password])
    #if user && user.authenticate(password_params[:password])  #ストロングパラメーターに変更
    if user && user.authenticate(user_params[:password])  #ストロングパラメーターを一つに集約
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_rul, info: 'ログアウトしました'
  end
  
  
  private
  def log_in(user)
    session[:user_id] = user.id
  end
  
#  def email_params   ストロングパラメーターを一つに集約
 #   params.require(:session).permit(:email)
  #end
  
  #def password_params　　ストロングパラメーターを一つに集約
    #params.require(:session).permit(:password)
  
  def user_params
    params.require(:session).permit(:email, :password)
    
  def log_out
    session.delete(:user_id)
    @current_user = nil
end
