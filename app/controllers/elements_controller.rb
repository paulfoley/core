class ElementsController < ApplicationController

  require 'cgi'
  require 'uri'

  def show
    @app = params[:app_name]
    if @app == "link_CRM" || @app == "a_CRM"
      redirect_to CloudElements.salesforce_oauthurl
    elsif @app == "link_accounting" || @app == "a_accounting"
      redirect_to CloudElements.quickbooks_oauthtoken
    elsif @app == "link_ecommerce" || @app == "a_ecommerce"
      redirect_to "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_84qPNMWLjrw7mUSm1MMKofy3ChAglggB&scope=read_write"
    end
  end

  def callback
    @uri_params = params
    redirect_to "https://corecloudapp.herokuapp.com/core/run?view=admin"
    @state = @uri_params[:state]
    if @state == "sfdc"
      CloudElements.salesforce_instance(session[:org], @uri_params[:code])
      CloudElements.salesforce_pull_everything(session[:org])
    elsif @state == "quickbooks"
      CloudElements.quickbooks_instance(session[:org], @uri_params[:oauth_token], @uri_params[:oauth_verifier], @uri_params[:realmId], @uri_params[:dataSource])
      CloudElements.quickbooks_pull_everything(session[:org])
    end

  end

  def stripe_callback
    @uri_params = params
    redirect_to "https://corecloudapp.herokuapp.com/core/run?view=admin"
    CloudElements.stripe_oauth(session[:org], @uri_params[:code])
    CloudElements.stripe_oauth_refresh
  end

end