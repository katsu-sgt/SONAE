class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.all
    @shelters = Shelters.all
    @item = Item.new
    @shelter = Shelter.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to items_path
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to items_path
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.requier(:item).permit(:item_name, :number, :replacement, :memo)
  end
end
