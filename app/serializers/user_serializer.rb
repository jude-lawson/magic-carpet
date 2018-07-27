class UserSerializer < ActiveModel::Serializer
  attributes :payload

  def payload
    JsonWebToken.encode(set_payload)
  end

  def set_payload
    {
      id: object.id,
      ride_count: object.ride_count,
      settings: {
        max_radius: object.setting.max_radius,
        min_radius: object.setting.min_radius,
        price: object.setting.price,
        min_rating: object.setting.min_rating,
      }
    }
  end
end
