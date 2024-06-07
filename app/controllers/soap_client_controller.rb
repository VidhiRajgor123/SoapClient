class SoapClientController < ApplicationController
    before_action :set_savon_client

    def index
        response = @client.call(:list_accounts)
        render json: response.to_hash
        rescue Savon::Error => e
            render json: { error: e.message }, status: :unprocessable_entity
    end
  
    def create
      response = @client.call(:create_account, message: { name: params[:name], email: params[:email] })
      render json: response.to_hash
      rescue Savon::Error => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
  
    def show
      response = @client.call(:get_account, message: { value: params[:id] })
      render json: response.to_hash
      rescue Savon::Error => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
  
    def update
      response = @client.call(:update_account, message: { id: params[:id], name: params[:name], email: params[:email] })
      render json: response.to_hash
      rescue Savon::Error => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
  
    def destroy
      response = @client.call(:delete_account, message: { value: params[:id] })
      render json: response.to_hash
      rescue Savon::Error => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
  
    private
  
    def set_savon_client
        @client = Savon.client(
            wsdl: "http://localhost:3000/api/accounts/wsdl",
            log: true,
            pretty_print_xml: true,
            env_namespace: :soapenv,
            namespaces: {
                "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
                "xmlns:wsdl" => "http://schemas.xmlsoap.org/wsdl/",
                "xmlns:soap" => "http://schemas.xmlsoap.org/wsdl/soap/",
                "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
                "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
                "xmlns:soap-enc" => "http://schemas.xmlsoap.org/soap/encoding/",
                "xmlns:tns" => "urn:WashOut"
            }
        )
    end
end