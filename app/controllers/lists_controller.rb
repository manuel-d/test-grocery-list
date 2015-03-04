class ListsController < ApplicationController
#http_basic_authenticate_with name: "", password: "", except: [] #except: [:index, :show]
before_action :get_list, only: [:edit, :update, :destroy]
before_action :check_auth, only: [:edit, :update, :destroy]
def check_auth
	if current_user.id != @list.user_id
		flash[:notice] = "Sorry, you can't edit this list"
		redirect_to(list_path)
	end
end

def get_list
	@list = List.find(params[:id])
end

def index
	@lists = current_user.lists.all
end

def show
	@list = current_user.lists.find(params[:id])
end

def new
	@list = List.new(params[:list])
end

def edit
end

def create
	@list = List.new(list_params)
	@list.user_id = current_user.id
	if @list.save
		redirect_to @list
	else
		render 'new'
	end
end

def update
	if @list.update(list_params)
		redirect_to @list
	else
		render 'edit'
	end
end

def destroy
	@list.destroy
	redirect_to @list
end

private
def list_params
	params.require(:list).permit(:title, :text)
end

end
