get "/new_item/:potluck_id" do
  @potluck = Potluck.find_by_id(params[:potluck_id])
  @potlucks = Potluck.new(params[:potluck])
  erb :"items/new_item"
end

get "/edit_item/:item_id" do
  @item = Item.find_by_id(params[:item_id])

  erb :"items/edit_item"
end


get "/item_assign/:item_id" do
  @item = Item.find_by_id(params[:item_id])

  erb :"items/item_assign"
end

#clean this up
post "/new_item" do
  @item = Item.new(params[:item])

  if @item.save
    @item.update_attributes(params[:item])

    redirect "/deets_potluck/#{params[:item][:potluck_id]}"
  else
    erb :"items/new_item"
  end
end

post "/save_item/:item_id" do
  @item = Item.find_by_id(params[:item_id])

  if @item.update_attributes(params[:item])

    redirect "/deets_potluck/#{params[:item][:potluck_id]}"
  else
    erb :"potlucks/:potluck_id"
  end
end

post "/item_assign/:item_id" do
  @item = Item.find_by_id(params[:item_id])

  if @item.update_attributes(params[:item])
    @person = Person.find_or_create_by_name(params[:person][:name])
    @item.update_attributes(:person_id => @person.id)

    redirect "/deets_potluck/#{params[:item][:potluck_id]}"
  else
    erb :"potlucks/:potluck_id"
  end
end




