class SearchController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    if @model == 'user'
      @records = User.search_for(@content)
      @records = @records.page(params[:page])
    else
      @records = Post.search_for(@content)
      @records = @records.page(params[:page])
    end
  end
end
