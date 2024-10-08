const functions = require('firebase-functions');
const admin = require('firebase-admin');
// To avoid deployment errors, do not call admin.initializeApp() in your code

// Source: https://www.youtube.com/@StevenNoCode 
// https://hundredacretech.com/
// get the full app and code here: https://itsstevenliu.gumroad.com/l/stripesubscription

const stripe = require('stripe')('XXXXXX'); //replace with actual key

exports.stripeWebhook = functions.https.onRequest(async (req, res) => {
    try {
        const sig = req.headers['stripe-signature'];
        const endpointSecret = 'XXXXXX'; // Replace with your actual endpoint secret

        const event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);

        if (event.type === 'customer.subscription.created') { // OR WHATEVER EVENT YOU"RE LISTENING FOR https://docs.stripe.com/api/events/types
            const dataObject = event.data.object;
            // Write what you need it to do here
        }

        if (event.type === 'customer.subscription.deleted') {
            const dataObject = event.data.object;
            // Write what you need it to do here
        }

        if (event.type === 'customer.subscription.updated') {
            const dataObject = event.data.object;
            // Write what you need it to do here
        }

        return res.sendStatus(200);
    } catch (err) {
        console.error("Error processing webhook:", err);
        return res.sendStatus(400);
    }
});
