class Reservation < ApplicationRecord
	has_one :guest

	def self.generate params
		reservation = nil
		if params[:reservation_code].present? || (params[:reservation].present? && params[:reservation][:code].present?)
			if params[:reservation_code].present?
				reservation 				= Reservation.find_or_create_by code:params[:reservation_code]
				reservation.code 			= params[:reservation_code]
				reservation.start_date 		= params[:start_date]
				reservation.end_date 		= params[:end_date]
				reservation.nights 			= params[:nights]
				reservation.number_of_guest = params[:guests]
				reservation.adults 			= params[:adults]
				reservation.children 		= params[:children]
				reservation.infants 		= params[:infants]
				reservation.status 			= params[:status]
				reservation.currency 		= params[:currency]
				reservation.payout_price 	= params[:payout_price]
				reservation.security_price 	= params[:security_price]
				reservation.total_price 	= params[:total_price]
				if reservation.save
					guest 					= reservation.guest || Guest.new
					guest.first_name 		= params[:guest][:first_name]
					guest.last_name 		= params[:guest][:last_name]
					guest.phone_number 		= params[:guest][:phone]
					guest.email 			= params[:guest][:email]
					guest.reservation 		= reservation
					guest.save
				end
			else
				current_reservation 		= params[:reservation]
				guest_details 				= current_reservation[:guest_details]
				guest_phone_numbers 		= current_reservation[:guest_phone_numbers].join(", ")
				reservation 				= Reservation.find_or_create_by code:current_reservation[:code]
				reservation.code 			= current_reservation[:reservation_code]
				reservation.start_date 		= current_reservation[:start_date]
				reservation.end_date 		= current_reservation[:end_date]
				reservation.nights 			= current_reservation[:nights]
				reservation.adults 			= guest_details[:number_of_adults]
				reservation.children 		= guest_details[:number_of_children]
				reservation.infants 		= guest_details[:number_of_infants]
				reservation.number_of_guest = (reservation.adults + reservation.children + reservation.infants)
				reservation.status 			= current_reservation[:status]
				reservation.currency 		= current_reservation[:host_currency]
				reservation.payout_price 	= current_reservation[:expected_payout_amount]
				reservation.security_price 	= current_reservation[:listing_security_price_accurate]
				reservation.total_price 	= current_reservation[:total_paid_amount_accurate]
				if reservation.save
					guest 					= reservation.guest || Guest.new
					guest.first_name 		= current_reservation[:guest_first_name]
					guest.last_name 		= current_reservation[:guest_last_name]
					guest.phone_number 		= current_reservation[:guest_phone_numbers]
					guest.email 			= current_reservation[:guest_email]
					guest.reservation 		= reservation
					guest.save
				end
			end
		end
		return reservation
	end
end
