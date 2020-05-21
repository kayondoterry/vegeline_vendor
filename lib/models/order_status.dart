class OrderStatus {
  static const PENDING = "pending";
  static const DELIVERY_IN_PROGRESS = "delivery_in_progress";
  static const WAITING_FOR_PAYMENT = "waiting_payment";
  static const WAITING_FOR_DELIVERY = "waiting_for_delivery";
  static const CANCELLED_BY_CUSTOMER = "canceled_by_customer";
  static const CANCELLED_BY_VENDOR = "canceled_by_vendor";
  static const COMPLETED = "completed";
  static const REJECTED = "rejected";
  static const VENDOR_PAYMENT_IN_PROGRESS = "vendor_payment_in_progress";
  static const VENDOR_PAYMENT_SUCCESSFUL = "vendor_payment_succesful";
  static const CUSTOMER_PAYMENT_IN_PROGRESS = "customer_payment_in_progress";

  static String getUserFriendlyStatus(String status) {
    String _userFriendlyString;
    switch (status) {
      case PENDING:
        _userFriendlyString = "Pending";
        break;
      case DELIVERY_IN_PROGRESS:
        _userFriendlyString = "Delivery in Progress";
        break;
      case WAITING_FOR_PAYMENT:
        _userFriendlyString = "Waiting for Customer's Approval";
        break;
      case CUSTOMER_PAYMENT_IN_PROGRESS:
        _userFriendlyString = "Waiting for Customer's Approval";
        break;
      case WAITING_FOR_DELIVERY:
        _userFriendlyString = "Waiting for Delivery";
        break;
      case CANCELLED_BY_CUSTOMER:
        _userFriendlyString = "Cancelled";
        break;
      case CANCELLED_BY_VENDOR:
        _userFriendlyString = "Cancelled";
        break;
      case COMPLETED:
        _userFriendlyString = "Delivery Succesful";
        break;
      case REJECTED:
        _userFriendlyString = "Rejected";
        break;
      case VENDOR_PAYMENT_IN_PROGRESS:
        _userFriendlyString = "Payment in Progress";
        break;
      case VENDOR_PAYMENT_SUCCESSFUL:
        _userFriendlyString = "Payment Successful";
        break;
      default:
        _userFriendlyString = "Unknown";
    }
    return _userFriendlyString;
  }

//  static Set orderStatusSet = [
//    PENDING,
//    DELIVERY_IN_PROGRESS,
//    COMPLETED,
//    CANCELLED_BY_CUSTOMER,
//    CANCELLED_BY_VENDOR,
//    WAITING_FOR_PAYMENT,
//    WAITING_FOR_DELIVERY,
//    REJECTED,
//    PAYMENT_IN_PROGRESS,
//    PAYMENT_SUCCESSFUL
//  ].toSet();
}
