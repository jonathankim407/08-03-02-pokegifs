class MonstersController < ApplicationController

  def index
    res = Typhoeus.get("http://pokeapi.co/api/v2/pokemon/pikachu/", followlocation: true)
    body = JSON.parse(res.body)
    render json: {
      id: body["id"],
      name: body["name"],
      types: body["types"].map do |type|
        type["type"]["name"]
      end
    }
  end

end
