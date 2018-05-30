require 'open_pay_resource'

class Commerces < OpenPayResource

  # Returns a Commerce information, given its secret key
  # and merchant id. If key and id are not given, it will
  # use those used to initialize the main module.
  # 
  # Reference: 
  # https://openpay.mx/docs/api/?shell#obtener-un-comercio
  #
  def get(merchant_id='', private_key='')

    @errors = false

    if merchant_id.empty?
      merchant_id = @merchant_id
    end
    
    if private_key.empty?
      private_key = @private_key
    end

    url = @base_url + "#{merchant_id}"

    LOG.debug("commerce:")
    LOG.debug("   GET Resource URL:#{url}")
    
    res=RestClient::Request.new(
        :method => :get,
        :url => url,
        :user => private_key,
        :timeout => @timeout,
        :ssl_version => :TLSv1_2,
        :headers => {:accept => :json,
                     :content_type => :json,
                     :user_agent => 'Openpay/v1  Ruby-API',
        }
    )
    json_out=nil
    begin
      json_out=res.execute
        #exceptions
    rescue Exception => e
      @errors=true
      #will raise the appropriate exception and return
      OpenpayExceptionFactory::create(e)
    end
  end
end