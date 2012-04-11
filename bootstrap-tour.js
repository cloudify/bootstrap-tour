(function() {
  var $;
  $ = jQuery;
  $.fn.extend({
    featureTour: function(options) {
      var cookie, log, settings;
      cookie = function(key, value, options) {
        var days, decode, result, t;
        if (arguments.length > 1 && String(value) !== "[object Object]") {
          options = jQuery.extend({}, options);
          if (value == null) {
            options.expires = -1;
          }
          if (typeof options.expires === "number") {
            days = options.expires;
            t = options.expires = new Date();
            t.setDate(t.getDate() + days);
          }
          value = String(value);
          return document.cookie = [encodeURIComponent(key), "=", (options.raw ? value : encodeURIComponent(value)), (options.expires ? "; expires=" + options.expires.toUTCString() : ""), (options.path ? "; path=" + options.path : ""), (options.domain ? "; domain=" + options.domain : ""), (options.secure ? "; secure" : "")].join("");
        }
        options = value || {};
        result = void 0;
        decode = (options.raw ? function(s) {
          return s;
        } : decodeURIComponent);
        if ((result = new RegExp("(?:^|; )" + encodeURIComponent(key) + "=([^;]*)").exec(document.cookie))) {
          return decode(result[1]);
        } else {
          return null;
        }
      };
      settings = {
        tipContent: '#featureTourTipContent',
        cookieMonster: false,
        cookieName: 'bootstrapFeatureTour',
        cookieDomain: false,
        debug: false
      };
      settings = $.extend(settings, options);
      log = function(msg) {
        if (settings.debug) {
          return typeof console !== "undefined" && console !== null ? console.log(msg) : void 0;
        }
      };
      return this.each(function() {
        var $tipContent, $tips;
        if (settings.cookieMonster && (cookie(settings.cookieName) != null)) {
          return;
        }
        $tipContent = $(settings.tipContent).first();
        if ($tipContent == null) {
          return;
        }
        $tips = $tipContent.find('li');
        $tips.each(function(idx) {
          var $li, $target, target, tip_data;
          $li = $(this);
          tip_data = $li.data();
          if ((target = tip_data['target']) == null) {
            return;
          }
          if (($target = $(target).first()) == null) {
            return;
          }
          $target.popover({
            trigger: 'manual',
            title: tip_data['title'] != null ? "" + tip_data['title'] + " <a class=\"tour-tip-close close\" data-touridx=\"" + (idx + 1) + "\">&times;</a>" : null,
            content: "<p>" + ($li.html()) + "</p><p style=\"text-align: right\"><a href=\"#\" class=\"tour-tip-next btn btn-success\" data-touridx=\"" + (idx + 1) + "\">" + ((idx + 1) < $tips.length ? 'Next <i class="icon-chevron-right icon-white"></i>' : '<i class="icon-ok icon-white"></i> Done') + "</a></p>",
            placement: tip_data['placement'] || 'right'
          });
          $li.data('target', $target);
          if (idx === 0) {
            return $target.popover('show');
          }
        });
        $('a.tour-tip-close').live('click', function() {
          return $(settings.tipContent).first().find("li:nth-child(" + ($(this).data('touridx')) + ")").data('target').popover('hide');
        });
        return $('a.tour-tip-next').live('click', function() {
          var next_tip, _ref;
          $(settings.tipContent).first().find("li:nth-child(" + ($(this).data('touridx')) + ")").data('target').popover('hide');
          next_tip = (_ref = $(settings.tipContent).first().find("li:nth-child(" + ($(this).data('touridx') + 1) + ")")) != null ? _ref.data('target') : void 0;
          if (next_tip != null) {
            return next_tip.popover('show');
          } else {
            if (settings.cookieMonster) {
              return cookie(settings.cookieName, 'ridden', {
                expires: 365,
                domain: settings.cookieDomain
              });
            }
          }
        });
      });
    }
  });
}).call(this);
