class SearchController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    if @model == 'user'
      @records = User.search_for(@content)
    else
      @records = Post.search_for(@content)
    end
  end
end
