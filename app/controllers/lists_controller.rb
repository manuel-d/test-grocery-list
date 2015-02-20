class ListsController < ApplicationController

http_basic_authenticate_with name: "Manuel", password: "Maura1979", except: [] #except: [:index, :show]

def index
	@lists = List.all
end

def show
	@list = List.find(params[:id])
end

def new
	@list = List.new(params[:list])
end

def edit
	@list = List.find(params[:id])
end 

def create
	@list = List.new(list_params)
	if @list.save
		redirect_to @list
	else
		render 'new'
	end
end

def update
	@list = List.find(params[:id])
	
	if @list.update(list_params)
		redirect_to @list
	else
		render 'edit'
	end
end

def destroy
	@list = List.find(params[:id])
	@list.destroy
	
	redirect_to @list
end

private
def list_params
	params.require(:list).permit(:title, :text)
end

end
