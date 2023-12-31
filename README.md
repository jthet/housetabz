# HouseTabz

**Housetabz sets out to revolutionize the way that bills are split in shared households. We act as the financial intermediary covering the costs of Wifi and Utility Bills, and then the roommates pay us.**

## Ruby Version

This project uses Ruby version 3.2.2.

## System Dependencies

There are no specific system dependencies required for this application.

## Configuration

Steps to operating the application. 

Clone the repository. Run Bundle Install in the terminal. Run gem install bundler. Run rails db:migrate. Add a stripe.rb file in config/initializers. That file should look like this - 

Rails.configuration.stripe = {
    publishable_key: '',
    secret_key: ''
  }
  
  include Stripe::Webhook

  Stripe.api_key = Rails.configuration.stripe[:secret_key]

  Go to Stripe.com, click on developers and then API keys to get the nessecary keys for the code above. 

  Add a .env file to the main folder of the application. Add WEBHOOK_SECRET=(webhook secret will go here). 

  I have been using ngrok to create a tunnel for my localhost. So usually its somelink.ngrok-free.app, and I create an webhook endpoint called somelink.ngrok-free.app/webhooks/stripe and use the webhook_secret key it gives me. 
Keep in mind the webhook secret stuff is only necessary if you want to see the functionality of completing payments via Stripe. 

Make sure to have a database communicating with the application. RN I am using TablePlus. To set it up run rails db:create, then rails db:migrate. To set up the database go to TablePlus or if you have some other way, im sure that works. Click the + at the top then click SQLite, name it and select the developement file in the db folder of your application.

## Database Creation

To create the database, run the following command:

rails db:create


## Database Initialization

To initialize the database, run the following command:

rails db:migrate


## Running the Test Suite

Instructions on how to run the test suite are not available at the moment. Please refer to the project documentation for further details.

## Services

This project utilizes the following external services:

- Ngrok: Download and install ngrok. Navigate to the location of the ngrok file in your terminal and run `./ngrok http 3000`. Copy the forwarding link generated by ngrok. In the `checkout_controller` under the `controllers` folder, insert the ngrok link into the success and cancel URLs. Go to Stripe.com and create a webhook with the ngrok link `/webhooks/stripe`. 

## Deployment Instructions

Run `bin/dev` in the application's terminal and then access the ngrok link in a web browser.

## Contributing

We welcome contributions to improve the design and functionality of HouseTabz. Please refer to the project documentation for guidelines on how to contribute. I am looking for a new and SAFE way to process payments, that wont charge me a fee per transaction. So having my own payment processor would be awesome. 

## License

GPL-3.0
