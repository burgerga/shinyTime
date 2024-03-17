// Enclose in IEFE
(function() {
// Escape jQuery selector metacharacters: !"#$%&'()*+,./:;<=>?@[\]^`{|}~
// Copied from shiny/srcjs/utils.js
var $escape = function(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, '\\$1');
};

var findLabelForElement = function(el) {
  return($(el).parent().find('label[for="' + $escape(el.id) + '"]'));
};

var clamp = function(num, min, max) {
  return Math.min(Math.max(num, min), max);
};

var inRange = function(num, min, max) {
  return (num >= min && num <= max);
};

var zeroPad = function(num) {
  return (num < 10 ? '0' + num: num);
};

var correctInputValue = function(el) {
  var $el = $(el);
  // if class is shinytime-civilian, return
  if($el.hasClass('shinytime-civilian')) return;
  // format as float
  var val = parseFloat($el.val());
  // Check if number is integer, if so put to fixed form (0.1e1 will become 1), else make 0
  var newVal = (val % 1 === 0) ? val.toFixed() : 0;
  // Make 0 if out of range, alternative would be clamping.
  if($el.hasClass('shinytime-hours')) {
   newVal = inRange(newVal, 0, 23) ? newVal : 0;
  } else {
   newVal = inRange(newVal, 0, 59) ? newVal : 0;
  }
  // correct minute step
  if($el.hasClass('shinytime-mins')){
    var step = $el.attr("step");
    if(step && step != 1) {
      newVal = inRange(newVal, 0, 55) ? Math.round(newVal / step) * step : 55;
    }
  }
  // Zero pad and update value
  $el.val(zeroPad(newVal));
};

// From https://stackoverflow.com/a/48512262/1439843
var roundTime = function(value, minutesToRound) {

  let roundTimeDate = (date) => {
    let ms = 1000 * 60 * minutesToRound; // convert minutes to ms
    return new Date(Math.round((new Date(date)).getTime() / ms) * ms);
  };

  roundedDate = roundTimeDate((new Date()).setHours(value.hour, value.min, value.sec));
  return {
    hour: zeroPad(roundedDate.getHours()),
    min: zeroPad(roundedDate.getMinutes()),
    sec: zeroPad(roundedDate.getSeconds())
  };
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
    // format hour for civilian time
    var $civilian = $(el).find('.shinytime-civilian');
    if ($civilian.length > 0) {
      var civilian = $civilian.val();
      var hour = parseInt(values[0], 10);
      if (civilian == 'AM') {
        if (hour == 12) {
          hour = 0;
        }
      } else if (civilian == 'PM') {
        if (hour < 12) {
          hour += 12;
        }
      }
      values[0] = hour;
    } else {
      var civilian = null;
    }
    // Return object with hour, min, sec and civilian
    return {
      hour: values[0],
      min:  values[1],
      sec:  (values.length > 2) ? values[2] : 0,
      civilian: civilian
    };
  },
  setValue: function(el, value) {
    var $inputs = $(el).find('input');
    // format minute step
    minuteSteps = $inputs.eq(1).attr("step");
    if(minuteSteps && minuteSteps != 1) value = roundTime(value, minuteSteps);
    // set min and sec values
    $inputs.eq(1).val(value.min);
    if ($inputs.length > 2) $inputs.eq(2).val(value.sec);
    // Set to civilian time from military time
    var $civilian = $(el).find('.shinytime-civilian');
    if ($civilian.length > 0 && value.civilian) {
      var hour = parseInt(value.hour, 10);
      if(value.civilian == 'AM') {
        if (hour == 0) {
          hour = 12;
        }
      } else if (value.civilian == 'PM') {
        if (hour > 12) {
          hour -= 12;
        }
      }
      // set hour value
      $inputs.eq(0).val(hour);
      // set civilian value
      $civilian.val(value.civilian);
    } else {
      // set hour value
      $inputs.eq(0).val(value.hour);
    }
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
    // Bind change event for input elements
    $(el).on("change.timeInputBinding", function(e) {
      correctInputValue(e.target);
      callback();
    });
    // Bind change event for civilian time
    var $civilian = $(el).find('.shinytime-civilian');
    if ($civilian.length > 0) {
      $civilian.on("change.shinytime-civilian", function(e) {
        callback();
      });
    }
  },
  unsubscribe: function(el) {
    // Unbind change event for input elements
    $(el).off(".timeInputBinding");
    // Unbind change event for civilian time
    var $civilian = $(el).find('.shinytime-civilian');
    if ($civilian.length > 0) {
      $civilian.off(".shinytime-civilian");
    }
  }
});

Shiny.inputBindings.register(timeInputBinding, 'my.shiny.timeInput');
})();
