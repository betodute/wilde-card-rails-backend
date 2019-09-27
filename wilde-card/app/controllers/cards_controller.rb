class CardsController < ApplicationController

    def index
        @cards = Cards.All
        render json: @cards
    end

    def show
    end

    def create
    end

    def destroy
    end

    # Custom Routes

    def input
        Card.request_snippets(input_params)
    end

    private

    def card_params
        # require card params
    end

    def input_params
        params.require(:card).permit(:input)
    end

end
