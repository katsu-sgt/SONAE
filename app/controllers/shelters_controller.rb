class SheltersController < ApplicationController
  def create
    @shelter = Shelter.new
  end
  
  def update
    @shelter = Shelter.find(params[:id])
  end
  
  def destroy
  end
  
  private
  def shelter_param
    params.require(:shelter).permit(:shelter_name, :address, :shelter_memo)
  end
end
