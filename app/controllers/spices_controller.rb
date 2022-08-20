class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    
    #GET /spices
    def index
        spices = Spice.all 
        render json: spices, status: 200
    end

    #POST /spices
    def create
        spice = Spice.create(spice_params)
        render json: spice, status: 201
    end

    #PATCH /spices/:id
    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: 202
    end

    #DELETE/spices/:id
    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private 

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find(params[:id])
    end

    def render_not_found
        render json: {error: "spice not found"}, status: 404
    end
end
