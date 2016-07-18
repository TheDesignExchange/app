# ./config/initializers/carrierwave.rb
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => "AWS",
    :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
  }
  config.fog_directory = ENV['S3_BUCKET']

  # use only one of the following 2 settings
  #config.asset_host = "http://#{ENV['S3_BUCKET']}.s3.amazonaws.com" # for no cloudfront
  config.asset_host = ENV['S3_CDN'] # for cloudfront

end