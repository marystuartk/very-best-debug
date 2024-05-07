class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def create
   query_address = params.fetch("query_address")
   query_name = params.fetch("query_name")
   query_neighborhood = params.fetch("query_neighborhood")

   venue = Venue.new

   venue.address = query_address
   venue.name = query_name
   venue.neighborhood = query_neighborhood

   if venue.save
      redirect_to("/venues/" + venue.id.to_s)
   else
      Rails.logger.error(venue.errors.full_messages)
   end
  end
  
  def update
    the_id = params.fetch("the_id")

    matching_venues = Venue.where({ :id => the_id })
    the_venue = matching_venues.at(0)

    the_venue.address = params.fetch("query_address")
    the_venue.name = params.fetch("query_name")
    the_venue.neighborhood = params.fetch("query_neighborhood")

    the_venue.save
    
    redirect_to("/venues/#{the_venue.id}")
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

end
