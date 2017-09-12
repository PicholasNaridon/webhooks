class ResponsesController < ApplicationController
  # GET /responses
 def index
   Tinypass::ClientBuilder.new
   Tinypass.sandbox = true
   Tinypass.aid = ENV['TINYPASS_AID']
   Tinypass.private_key = ENV['TINYPASS_PRIVATE_KEY']
   @responses = Response.all
   render json: @responses
   the_params = params[:data]
   if the_params != nil
     Response.create!(data: (Tinypass::SecurityUtils.decrypt(ENV['TINYPASS_PRIVATE_KEY'], the_params )))
   end
 end

 # POST /responses
 def create
   @response = Response.create!(response_params)
   render json: @response
 end

 # GET /responses/:id
 def show
   render json: @response
 end

 # PUT /responses/:id
 def update
   @response.update(response_params)
   head :no_content
 end

 # DELETE /responses/:id
 def destroy
   @response.destroy
   head :no_content
 end

 private

 def response_params
   # whitelist params
   params.permit(:data)
 end

 def set_response
   @response = Response.find(params[:id])
 end
end
