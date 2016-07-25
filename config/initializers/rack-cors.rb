## Configure Rack CORS Middleware, so that CloudFront can serve our assets.
## See https://github.com/cyu/rack-cors

if defined? Rack::Cors
    Rails.configuration.middleware.insert_before 0, Rack::Cors do
        allow do
            origins %w[
                https://thedesignexchange.herokuapp.com
                 http://thedesignexchange.herokuapp.com
                https://www.thedesignexchange.org
                 http://www.thedesignexchange.org
                https://thedesignexchange-staging.herokuapp.com
                 http://thedesignexchange-staging.herokuapp.com
            ]
            resource '/assets/*'
        end
    end
end