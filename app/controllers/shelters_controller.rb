class SheltersController < ApplicationController
  before_action :authenticate_user!

  def create
    @shelter = Shelter.new(shelter_params)
    @shelter.user_id = current_user.id
    @shelter.save
    redirect_to items_path
  end

  def index
    @shelters = Shelter.all
    # csv処理
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_shelters_csv(@shelters)
      end
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end 

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    redirect_to items_path
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    @shelter.destroy
    redirect_to items_path
  end

  private

  def shelter_params
    params.require(:shelter).permit(:shelter_name, :address, :shelter_memo)
  end

  # 避難所csv出力
  def send_shelters_csv(shelters)
    csv_data = CSV.generate do |csv|
      column_names = %w(名称 住所 メモ)
      csv << column_names
      shelters.each do |shelter|
        column_values = [
          shelter.shelter_name,
          shelter.address,
          shelter.shelter_memo,
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "避難所リスト一覧.csv")
  end
end