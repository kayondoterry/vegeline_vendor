const axios = require("axios").default;

// axios
//   .post("https://api.ravepay.co/flwv3-pug/getpaidx/api/v2/verify", {
//     txref: "7535101f-e05b-4073-a963-61d2381808cd",
//     SECKEY: "FLWSECK-a05d7f3cea028c4b6555201c1c4356d6-X",
//   })
//   .then((response) => {
//     console.log(response);
//   })
//   .catch((err) => {
//     console.log(err.response);
//   });

// axios
//   .post("https://api.ravepay.co/v2/gpx/transfers/create", {
//     account_bank: "MPS",
//     account_number: "256756786156",
//     amount: 500,
//     seckey: "FLWSECK-a05d7f3cea028c4b6555201c1c4356d6-X",
//     narration: "New transfer",
//     currency: "UGX",
//     beneficiary_name: "David Banes", // only pass this for non NGN
//   })
//   .then((response) => {
//     console.log(response);
//   })
//   .catch((err) => {
//     console.log(err.response || err);
//   });

axios
  .get("https://api.ravepay.co/v2/gpx/transfers", {
    data: {
      seckey: "FLWSECK-a05d7f3cea028c4b6555201c1c4356d6-X",
      id: "1650487",
      reference: "facdc60e7c37af7c",
    },
  })
  .then((response) => {
    console.log(response.data.data);
  })
  .catch((err) => {
    console.log(err.response || err);
  });

  let boo = {
    page_info: { total: 5, current_page: 1, total_pages: 1 },
    transfers: [
      {
        id: 1654475,
        account_number: "256709747133",
        bank_code: "MPS",
        fullname: "SimXYYY BuckY",
        date_created: "2020-05-14T22:05:26.000Z",
        currency: "UGX",
        debit_currency: null,
        amount: 126000,
        fee: 2000,
        status: "PENDING",
        reference: "b8cb3a957f52d16d",
        meta: null,
        narration: "New transfer",
        approver: null,
        complete_message: "",
        requires_approval: 0,
        is_approved: 1,
        bank_name: "FA-BANK",
      },
      {
        id: 1654469,
        account_number: "256789786156",
        bank_code: "MPS",
        fullname: "SimX BuckY",
        date_created: "2020-05-14T22:04:12.000Z",
        currency: "UGX",
        debit_currency: null,
        amount: 15000,
        fee: 2000,
        status: "FAILED",
        reference: "822664960671cf8d",
        meta: null,
        narration: "New transfer",
        approver: null,
        complete_message:
          "DISBURSE FAILED: Insufficient funds in customer wallet",
        requires_approval: 0,
        is_approved: 1,
        bank_name: "FA-BANK",
      },
      {
        id: 1654419,
        account_number: "256789786156",
        bank_code: "MPS",
        fullname: "Sim Buck",
        date_created: "2020-05-14T21:53:49.000Z",
        currency: "UGX",
        debit_currency: null,
        amount: 500,
        fee: 2000,
        status: "FAILED",
        reference: "5f493f6f09e58aaa",
        meta: null,
        narration: "New transfer",
        approver: null,
        complete_message:
          "DISBURSE FAILED: Insufficient funds in customer wallet",
        requires_approval: 0,
        is_approved: 1,
        bank_name: "FA-BANK",
      },
      {
        id: 1654407,
        account_number: "256756786156",
        bank_code: "MPS",
        fullname: "David Banes",
        date_created: "2020-05-14T21:47:33.000Z",
        currency: "UGX",
        debit_currency: null,
        amount: 500,
        fee: 2000,
        status: "FAILED",
        reference: "97855378179fcc58",
        meta: null,
        narration: "New transfer",
        approver: null,
        complete_message:
          "DISBURSE FAILED: Insufficient funds in customer wallet",
        requires_approval: 0,
        is_approved: 1,
        bank_name: "FA-BANK",
      },
      {
        id: 1650487,
        account_number: "256756786156",
        bank_code: "MPS",
        fullname: "David Banes",
        date_created: "2020-05-14T11:15:48.000Z",
        currency: "UGX",
        debit_currency: null,
        amount: 500,
        fee: 2000,
        status: "FAILED",
        reference: "facdc60e7c37af7c",
        meta: null,
        narration: "New transfer",
        approver: null,
        complete_message:
          "DISBURSE FAILED: Insufficient funds in customer wallet",
        requires_approval: 0,
        is_approved: 1,
        bank_name: "FA-BANK",
      },
    ],
  };
