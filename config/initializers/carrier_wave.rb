CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"    

  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV['S3_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['S3_SECRET_ACCESS_ID'],
    :region => ENV['S3_REGION']
    }
  config.fog_directory = ENV['S3_BUCKET_NAME']
  
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end

  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end
end
