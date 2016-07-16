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
    return values;
  },
  setValue: function(el) {
    //TODO implement
    throw "Not implemented";
  },
  receiveMessage: function(el, data) {
    // To get updateTimeInput working
    //TODO implement
    throw "Not implemented";
    /* Example from shiny/srcjs/input_binding_number.js
    if (data.hasOwnProperty('value'))  el.value = data.value;
    if (data.hasOwnProperty('min'))    el.min   = data.min;
    if (data.hasOwnProperty('max'))    el.max   = data.max;
    if (data.hasOwnProperty('step'))   el.step  = data.step;

    if (data.hasOwnProperty('label'))
      $(el).parent().find('label[for="' + $escape(el.id) + '"]').text(data.label);

    $(el).trigger('change');
    */
  },
  getState: function(el) {
    //TODO implement, but what is it supposed to do?
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
