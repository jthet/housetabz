# HouseTabz

**Housetabz sets out to revolutionize the way that bills are split in shared households. We act as the financial intermediary covering the costs of Wifi and Utility Bills, and then the roommates pay us.**

## Ruby Version

This project uses Ruby version 3.2.2.

## System Dependencies

There are no specific system dependencies required for this application.

## Configuration

No additional configurations are needed for this project.

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

We welcome contributions to improve the design and functionality of HouseTabz. Please refer to the project documentation for guidelines on how to contribute.

## License

This project is distributed under no specific license.
