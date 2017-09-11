class ResponsesController < ApplicationController
  # GET /responses
 def index
   @responses = Response.all
   json_response(@responses)
 end

 # POST /responses
 def create
   @response = Response.create!(response_params)
   json_response(@response, :created)
 end

 # GET /responses/:id
 def show
   json_response(@response)
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
   params.permit(:body)
 end

 def set_response
   @response = Response.find(params[:id])
 end
end
