# Wolfminute

This is a web app to optimize meeting and make it more efficient.
If you book meeting, this app automatically suggest a date and time and chat GPT creates agenda for your meeting.
During meeting, you can check the rest of the time with agenda and record your voice and chat GPT creates summary.
After meeting, you can check analytics about past meetings as well.

App home: https://wolfminute.herokuapp.com


## Getting Started
### Setup

Install gems
```
bundle install
```
Install JS packages
```
yarn install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
yarn build --watch
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Team Members
- Rika Saito
- Juan Bernal
- Jun Ukemori
- Xuemei Huang

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License
