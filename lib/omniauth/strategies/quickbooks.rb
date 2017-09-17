require "omniauth/strategies/oauth2"

module OmniAuth
  module Strategies
    class Quickbooks < OmniAuth::Strategies::OAuth2
      option :name, "quickbooks"
      option :authorize_options, [:scope, :state]
      option :client_options,
             site: "https://appcenter.intuit.com",
             authorize_url: "https://appcenter.intuit.com/connect/oauth2",
             token_url: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"
      DEFAULT_SCOPE = "com.intuit.quickbooks.accounting"

      uid {
        request.params['realmId']
      }

      def authorize_params
        super.tap do |params|
          %w[scope state].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end

          params[:scope] ||= DEFAULT_SCOPE
        end
      end

    end
  end
end