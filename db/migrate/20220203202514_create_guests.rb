class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
    	t.integer 	:reservation_id
    	t.string 	:email
    	t.string 	:first_name
    	t.string 	:last_name
    	t.string 	:phone_number
		t.timestamps
    end
  end
end
