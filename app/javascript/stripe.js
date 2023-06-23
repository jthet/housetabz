// Assuming you have access to the current user's ID
const user_id = getCurrentUserId(); // Replace with the actual code to get the user ID

// Create a payment intent on the client side
stripe.paymentIntents.create({
  amount: 1000, // replace with the actual amount
  currency: 'usd', // replace with the actual currency
  metadata: {
    user_id: user_id // Use the actual user ID value
  }
}).then(function(result) {
  // Handle the result
});

