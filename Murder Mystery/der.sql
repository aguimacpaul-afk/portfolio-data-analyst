crime_scene_report:
|- date 
|- type: "kind of crime"
|- description
|- city

drivers_licence:
|- id pk
|- age
|- height
|- eye_color
|- hair_color
|- gender
|- plate_number
|- car_make
|- car_model

facebook_event_checkin
|- person_id ---->
|- event_id
|- event_name
|- date # esta como entero

get_fit_now_check_in
|- membership_id
|- check_in_date
|- check_in_time
|- check_out_time

get_fit_now_member
|- id pk
|- person_id fk: person.id
|- name
|- membership_start_date
|- membership_status

income
|- ssn 
|- annual_income

interview
|- person_id
|- transcript

person
|- id pk
|- name
|- license_id fk: driver_license.id
|- address_number
|- address_street_name
|- ssn fk: income.ssn

solution
|- user
|- value

