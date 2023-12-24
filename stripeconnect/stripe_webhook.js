const functions = require('firebase-functions');
const admin = require('firebase-admin');
// To avoid deployment errors, do not call admin.initializeApp() in your code

const stripe = require('stripe')('##############'); //YOUR STRIPE KEY HERE

// Change Region to your GCP resource location and add async to the function
exports.stripeWebhook = functions.region('us-central').
	runWith({
		memory: '128MB'
  }).https.onRequest( async  (req, res) => {
    // Write your code below!
   
      try {
        const sig = req.headers['stripe-signature'];
        const endpointSecret = '##############'; // ACTUAL ENDPOINT SECRET HERE
        const event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);

        if (event.type === 'checkout.session.completed') {
            // Handle checkout session completed event
            const dataObject = event.data.object;

            await admin.firestore().collection("payments").doc().set({
                checkoutSessionId: dataObject.id,
                paymentStatus: dataObject.payment_status,
                amountTotal: dataObject.amount_total,
                amountCurrency: dataObject.currency,
                // Add more fields as needed
                // ...
                timestamp: admin.firestore.FieldValue.serverTimestamp()
            });


        }

          return res.sendStatus(200);
    } catch (err) {
        return res.sendStatus(400);
    }
    // Write your code above!
  }
);
