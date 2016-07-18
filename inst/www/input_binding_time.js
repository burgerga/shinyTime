
// Escape jQuery selector metacharacters: !"#$%&'()*+,./:;<=>?@[\]^`{|}~
// Copied from shiny/srcjs/utils.js
var $escape = function(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, '\\$1');
};

var findLabelForElement = function(el) {
  return($(el).parent().find('label[for="' + $escape(el.id) + '"]'));
};

var timeInputBinding = new Shiny.InputBinding();

$.extend(timeInputBinding, {
  find: function(scope) {
    return $(scope).find('.my-shiny-time-input');
  },
  getValue: function(el) {
    var $inputs = $(el).find('input');
    var values = [];
    $inputs.each(function() {
      numberVal = $(this).val();
      // Number parsing logic taken from shiny/srcjs/input_binding_number.js
      if (/^\s*$/.test(numberVal))  // Return null if all whitespace
        values.push(null);
      else if (!isNaN(numberVal))   // If valid Javascript number string, coerce to number
        values.push(+numberVal);
      else
        values.push(numberVal);
    });
    return {
      hour: values[0],
      min:  values[1],
      sec:  values[2]};
  },
  setValue: function(el, value) {
    var $inputs = $(el).find('input');
    $inputs.eq(0).val(value.hour);
    $inputs.eq(1).val(value.min);
    $inputs.eq(2).val(value.sec);
  },
  receiveMessage: function(el, data) {
    // To get updateTimeInput working
    if (data.hasOwnProperty('label')) findLabelForElement(el).text(data.label);
    if (data.hasOwnProperty('value')) this.setValue(el, data.value);
    $(el).trigger('change');
  },
  getState: function(el) {
    return {
      label: findLabelForElement(el).text(),
      value: this.getValue(el)
    };
  },
  getType: function() {
    // Necessary to get the registerInputHandler working
    return "my.shiny.timeInput";
  },
  subscribe: function(el, callback) {
    $(el).on("change.timeInputBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".timeInputBinding");
  }
});

Shiny.inputBindings.register(timeInputBinding, 'my.shiny.timeInput');
