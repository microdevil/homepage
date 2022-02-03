class ReservationsController < ApplicationController

	def submit
		# puts params[:reservation_code]
		if params[:reservation_code].present? || (params[:reservation].present? && params[:reservation][:code].present?)
			reservation = Reservation.generate params
			if reservation.nil?
				render json: {
					data:"hello"
				}, status: :unprocessable_entity
			else
				render json: {
					data:reservation
				},status: :ok
			end
		else
			render json: {data:"hello"}, status: :unprocessable_entity
		end
	end

end
