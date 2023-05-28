require 'google/apis/calendar_v3'

Google::Apis::RequestOptions.default.authorization =
  Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: File.open('wolfminute-6fa671da7ea3.json'),
    scope: 'https://www.googleapis.com/auth/calendar'
  )
