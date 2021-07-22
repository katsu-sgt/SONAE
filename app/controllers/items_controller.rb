class ItemsController < ApplicationController
  before_action :authenticate_user!
  require 'csv'

  def index
    @items = current_user.items
    @shelters = Shelter.all
    @item = Item.new
    @shelter = Shelter.new

    # csv処理
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_items_csv(@items)
      end
    end
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.save
    redirect_to items_path
  end

  def edit
    @item = Item.find(params[:id])
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
    params.require(:item).permit(:item_name, :number, :replacement, :item_memo)
  end

  # 品目csv出力
  def send_items_csv(items)
    csv_data = CSV.generate do |csv|
      column_names = %w(品名 個数 交換時期 メモ)
      csv << column_names
      items.each do |item|
        column_values = [
          item.item_name,
          item.number,
          item.replacement,
          item.item_memo,
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "物品リスト一覧.csv")
  end
end
