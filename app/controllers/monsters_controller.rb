class MonstersController < ApplicationController

  def show
    poke_api_response = Typhoeus.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/", followlocation: true)
    poke_body = JSON.parse(poke_api_response.body)

    giphy = Typhoeus.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{poke_body["name"]}&rating=g", followlocation: true)
    giphy_body = JSON.parse(giphy.body)

    render json: {
      id: poke_body["id"],
      name: poke_body["name"],
      types: poke_body["types"].map do |type|
        type["type"]["name"]
      end,
      gif: giphy_body["data"].first["images"]["original"]["url"]
    }
  end

end
