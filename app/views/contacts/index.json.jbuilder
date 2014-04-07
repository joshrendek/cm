json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :sex, :age, :birthday, :phone, :email
  json.url contact_url(contact, format: :json)
end
