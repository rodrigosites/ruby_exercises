require 'csv'
require 'erb'
require 'google/apis/civicinfo_v2'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(phone_number)
  phone_number.delete!('-() .')
  phone_number_length = phone_number.to_s.length
  if phone_number_length == 11 && phone_number.to_s[0] == "1"
    phone_number.to_s[1..10]
  elsif phone_number_length == 10
    phone_number
  else
    'bad number'
  end
end

def find_registration_peak_hours(registration_hours)
  puts 'Showing register hours by quantity:'
  registration_hours.each_pair do |key, value|
    puts "#{key}:00 - #{value} registers."
  end
  registration_hours.filter do |key, value|
    puts "Peak hour at #{key}:00 with #{value} registrations." if value == registration_hours.values.max
  end
end

def save_registration_hour(registration_date, registration_hours)
  registration_hour = DateTime.strptime(registration_date, '%m/%d/%Y %H:%M').hour
  if registration_hours.include?(registration_hour)
    registration_hours[registration_hour] += 1
  else
    registration_hours[registration_hour] = 1
  end
  registration_hours
end

def find_registration_peak_days(registration_days)
  puts 'Showing register days by quantity:'
  registration_days.each_pair do |key, value|
    puts "#{Date::DAYNAMES[key]} - #{value} registers."
  end
  registration_days.filter do |key, value|
    puts "Peak day at #{Date::DAYNAMES[key]} with #{value} registrations." if value == registration_days.values.max
  end
end

def save_registration_day(registration_date, registration_days)
  registration_day = DateTime.strptime(registration_date, '%m/%d/%Y %H:%M').wday
  if registration_days.include?(registration_day)
    registration_days[registration_day] += 1
  else
    registration_days[registration_day] = 1
  end
  registration_days
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'Event Manager Initialized!'

if File.exist?('./event_attendees.csv')
  contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)
end

template_letter = File.read('./form_letter.erb')
erb_template = ERB.new template_letter

registration_hours = {}
registration_days = {}

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  registration_date = row[:regdate]
  registration_hours = save_registration_hour(registration_date, registration_hours)
  registration_days = save_registration_day(registration_date, registration_days)

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)

  puts "Saving letter for #{id} - #{name}"
  puts "Phone number is a #{phone_number}" if phone_number.eql?('bad number')
end

find_registration_peak_hours(registration_hours)
find_registration_peak_days(registration_days)