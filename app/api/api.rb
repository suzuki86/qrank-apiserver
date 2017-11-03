class API < Grape::API
  include Grape::Kaminari

  version 'v1'
  format :json
  prefix '/api'

  resource :entries do
    paginate per_page: 20, max_per_page: 100

    params do
      optional :page, type: Integer, desc: "Specify page number"
      optional :orderby, type: String, desc: "Specify order"
      optional :tag, type: String, desc: "Filter by tag"
      optional :days, type: Integer, desc: "Filter by days"
      optional :user_id, type: Integer, desc: "Filter by user"
      optional :per_page, type: Integer, desc: "Number of entries to be paginated."
    end

    get "/" do
      if params[:orderby] then
        orderby = params[:orderby]
      else
        orderby = "id"
      end

      if params[:tag] then
        where = "tags.tag_name = :tag"
      else
        where = ""
      end

      if params[:days] then
        unless where.empty? then
          where += " AND"
        end
        where += ' str_to_date(entries.entry_created, "%Y-%m-%d %H:%i:%s") > NOW() - INTERVAL :days DAY'
      end

      if params[:user_id] then
        unless where.empty? then
          where += " AND"
        end
        where += " entries.user_id = :user_id"
      end

      if params[:tag] then
        entries = Entry
          .eager_load(:tags)
          .order(orderby.to_sym => :desc)
          .where(where, {
            :tag => params[:tag],
            :user_id => params[:user_id],
            :days => params[:days]
          })
      else
        entries = Entry
          .order(orderby.to_sym => :desc)
          .where(where, {
            :user_id => params[:user_id],
            :days => params[:days]
          })
          .page(params[:page])
      end

      paginate(entries).as_json(:include => :tags)
    end

    get "/count" do
      Entry.count
    end
  end

  resource :tags do
    params do
      optional :page, type: Integer, desc: "Specify page number"
    end

    get "/" do
      Tag.order(:id => :desc).page(params[:page]).as_json(:include => :entries)
    end
  end

  resource :users do
    params do
      optional :page, type: Integer, desc: "Specify page number"
      optional :orderby, type: String, desc: "Specify order"
    end

    get "/" do
      if params[:orderby] then
        orderby = params[:orderby]
      else
        orderby = "id"
      end
      User.order(orderby.to_sym => :desc).page(params[:page]).as_json(:include => :entries)
    end

    get "/count" do
      User.count
    end
  end

  resource :ranking do
    get "/users/like" do
      User.ranking("like_total")
    end

    get "/users/hatebu" do
      User.ranking("hatebu_total")
    end

    get "/users/item" do
      User.ranking("users.items")
    end

    get "/tags" do
      Tag
        .select("
          tags.id,
          tags.tag_name,
          count(*) AS entries_count
        ")
        .group(:tag_name)
        .order("entries_count DESC")
    end
  end
end
