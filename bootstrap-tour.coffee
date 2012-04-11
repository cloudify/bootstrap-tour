# ===========================================================
# bootstrap-tour.js v0.0.1
# ===========================================================
# Copyright 2012 Gild, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# =========================================================== 
# 
#
# **Usage:**
# 
#     $("body").featureTour({
#       debug: true
#     }
# 

# References jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend {}=

  featureTour: (options) ->

    # based on jQuery Cookie plugin
    # Copyright (c) 2010 Klaus Hartl (stilbuero.de)
    # Dual licensed under the MIT and GPL licenses:
    # http://www.opensource.org/licenses/mit-license.php
    # http://www.gnu.org/licenses/gpl.html
    cookie = (key, value, options) ->
      if arguments.length > 1 and String(value) isnt "[object Object]"
        options = jQuery.extend({}, options)
        options.expires = -1 unless value?
        if typeof options.expires is "number"
          days = options.expires
          t = options.expires = new Date()
          t.setDate t.getDate() + days
        value = String(value)
        return (document.cookie = [ encodeURIComponent(key), "=", (if options.raw then value else encodeURIComponent(value)), (if options.expires then "; expires=" + options.expires.toUTCString() else ""), (if options.path then "; path=" + options.path else ""), (if options.domain then "; domain=" + options.domain else ""), (if options.secure then "; secure" else "") ].join(""))
      options = value or {}
      result = undefined
      decode = (if options.raw then (s) ->
        s
      else decodeURIComponent)
      return (if (result = new RegExp("(?:^|; )" + encodeURIComponent(key) + "=([^;]*)").exec(document.cookie)) then decode(result[1]) else null)

    # Default settings
    settings =
      tipContent: '#featureTourTipContent' # What is the ID of the <ol> you put the content in
      cookieMonster: false                 # true or false to control whether cookies are used
      cookieName: 'bootstrapFeatureTour'   # Name the cookie you'll use
      cookieDomain: false                  # Will this cookie be attached to a domain, ie. '.mydomain.com'
      debug: false
      
    # Merge default settings with options.
    settings = $.extend settings, options
    
    # Simple logger.
    log = (msg) ->
      console?.log msg if settings.debug
    
    return @each () ->
      return if settings.cookieMonster && cookie(settings.cookieName)?

      $tipContent = $(settings.tipContent).first()
      return unless $tipContent?
      
      $tips = $tipContent.find('li')
      $tips.each (idx) ->
        $li = $(@)
        tip_data = $li.data()
        return unless (target = tip_data['target'])?
        return unless ($target = $(target).first())?
        
        $target.popover
          trigger: 'manual'
          title: if tip_data['title']? then "#{tip_data['title']} <a class=\"tour-tip-close close\" data-touridx=\"#{idx + 1}\">&times;</a>" else null
          content: "<p>#{$li.html()}</p><p style=\"text-align: right\"><a href=\"#\" class=\"tour-tip-next btn btn-success\" data-touridx=\"#{idx + 1}\">#{if (idx + 1) < $tips.length then 'Next <i class="icon-chevron-right icon-white"></i>' else '<i class="icon-ok icon-white"></i> Done'}</a></p>"
          placement: tip_data['placement'] || 'right'
        
        # save the target element in the tip node
        $li.data('target', $target)
        
        # show the first tip
        $target.popover('show') if idx == 0

      # handle the close button
      $('a.tour-tip-close').live 'click', ->
        $(settings.tipContent).first().find("li:nth-child(#{$(@).data('touridx')})").data('target').popover('hide')

      # handle the next and done buttons
      $('a.tour-tip-next').live 'click', ->
        $(settings.tipContent).first().find("li:nth-child(#{$(@).data('touridx')})").data('target').popover('hide')
        next_tip = $(settings.tipContent).first().find("li:nth-child(#{$(@).data('touridx') + 1})")?.data('target')
        if next_tip?
          next_tip.popover('show')
        else
          # last tip
          cookie(settings.cookieName, 'ridden', { expires: 365, domain: settings.cookieDomain }) if settings.cookieMonster
