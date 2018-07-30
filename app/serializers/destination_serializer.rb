class DestinationSerializer < ActiveModel::Serializer
  attributes :id, 
              :name, 
              :rating,
              :categories,
              :latitude,
              :longitude,
              :street_address,
              :city,
              :state,
              :zip_code,
              :distance,
              :categories
end
