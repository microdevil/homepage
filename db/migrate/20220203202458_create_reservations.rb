class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
    	t.string 	:code
    	t.date 		:start_date
    	t.date 		:end_date
    	t.integer 	:nights
    	t.integer 	:number_of_guest
    	t.integer 	:adults
    	t.integer 	:children
    	t.integer 	:infants
    	t.string 	:status
    	t.string 	:currency
    	t.float 	:payout_price
    	t.float 	:security_price
    	t.float 	:total_price
      	t.timestamps
    end
  end
end
