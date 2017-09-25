const flatpickr = require('flatpickr');

flatpickr(dateFieldId, {
  dateFormat: "Y-m-d",
  minDate: "today",
  disable: [
    date => date.getDay() !== 3
  ],
  locale: {
    "firstDayOfWeek": 1
  }
});
