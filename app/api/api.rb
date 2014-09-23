class API < Grape::API
  version 'v1'
  format :json
  prefix '/api'

  resource :entries do
    params do
      optional :page, type: Integer, desc: "Specify page number"
      optional :orderby, type: String, desc: "Specify order"
      optional :tag, type: String, desc: "Filter by tag"
      optional :days, type: Integer, desc: "Filter by days"
      optional :user, type: String, desc: "Filter by user"
    end
    get '/' do
      if params[:orderby] then
        orderby = params[:orderby]
      else
        orderby = "id"
      end

      if params[:tag] then
        where = 'tags.tag_name = "' + params[:tag] + '"'
      else
        where = ""
      end

      if params[:days] then
        unless where.empty? then
          where += " AND"
        end
        where += ' str_to_date(entries.entry_created, "%Y-%m-%d %H:%i:%s") > NOW() - INTERVAL ' + params[:days].to_s + ' DAY'
      end

      if params[:user] then
        unless where.empty? then
          where += " AND"
        end
        where += ' entries.user_name = "' + params[:user] + '"'
      end

      if params[:tag] then
        Entry.joins(:tags).order(orderby.to_sym => :desc).where(where).as_json(:include => :tags)
      else
        Entry.order(orderby.to_sym => :desc).where(where).page(params[:page]).as_json(:include => :tags)
      end
    end
  end

  resource :tags do
    params do
      optional :page, type: Integer, desc: "Specify page number"
    end
    get '/' do
      Tag.order(:id => :desc).page(params[:page]).as_json(:include => :entries)
    end
  end

  resource :users do
    params do
      optional :page, type: Integer, desc: "Specify page number"
      optional :orderby, type: String, desc: "Specify order"
      optional :ranking, type: String, desc: "Specify ranking"
    end
    get '/' do
      if params[:orderby] then
        orderby = params[:orderby]
      else
        orderby = "id"
      end

      if params[:ranking] then
        User
        .joins(:entries)
        .select("users.id, users.user_name, sum(entries.stock_count) AS stock_total, sum(entries.hatebu_count) AS hatebu_total, users.items")
        .group(:id)
        .order(params[:ranking] + " DESC")
      else
        User.order(orderby.to_sym => :desc).page(params[:page]).as_json(:include => :entries)
      end
    end
  end
end
