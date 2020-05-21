import 'package:flutter/material.dart';

const textInputDecoration = const InputDecoration();

const appBarTitle = const Text(
  'Vege-Line',
  style: TextStyle(
    fontFamily: 'cursive',
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
);

const MESSAGE_PENDING = "Please accept or reject this order.";
const MESSAGE_DELIVERY_IN_PROGRESS =
    "Waiting for customer to approve delivery.";
const MESSAGE_WAITING_FOR_PAYMENT = "Waiting for customer to approve.";
const MESSAGE_WAITING_FOR_DELIVERY =
    "Enter the details relevant to the delivery and confirm.";
const MESSAGE_CANCELLED_BY_CUSTOMER =
    "This order has been cancelled by the customer.";
const MESSAGE_CANCELLED_BY_VENDOR = "This order has been cancelled by you.";
const MESSAGE_COMPLETED =
    "Delivery succesful. Enter Airtel phone number to receive your pay.";
const MESSAGE_REJECTED = "You have rejected this delivery.";
const MESSAGE_VENDOR_PAYMENT_IN_PROGRESS =
    "Please wait as your pay is transferred.";
const MESSAGE_PAYMENT_SUCCESSFUL =
    "Your pay has been succesfully transferred. Thank you for using VegeLine";

const FLUTTERWAVE_CREATE_TRANSFER_ENDPOINT =
    "https://api.ravepay.co/v2/gpx/transfers/create";

const FLUTTERWAVE_GET_TRANSFER_ENDPOINT =
    "https://api.ravepay.co/v2/gpx/transfers";
