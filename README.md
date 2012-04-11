# Bootstrap Tour

Bootstrap Tour is an easy to configure site tour wizard based on [Twitter Boostrap](http://twitter.github.com/bootstrap) and inspired by [Joyride](http://www.zurb.com/playground/jquery-joyride-feature-tour-plugin).

Bootstrap Tour is MIT-licensed and absolutely free to use.

## Documentation

Bootstrap Tour is inspired by [Joyride](http://www.zurb.com/playground/jquery-joyride-feature-tour-plugin) and relies on a similar structure for the tour markup.

### Add Bootstrap Tour to your page

    /* Boostrap Tooltip and Popup javascripts needs to be attached */
    <script src="bootstrap-tooltip.js" type="text/javascript"></script>
	<script src="bootstrap-popup.js" type="text/javascript"></script>
	
    /* Then attach the Bootstrap Tour plugin */
    <script src="bootstrap-tour.js" type="text/javascript"></script>

### Define the attach points

	/* Bootstrap Tour can be attached to any element with a unique ID, in any order */
	<h3 id="yourHeaderID"></h3>
	<p id="yourParagraphID">

	<a id="yourAnchorID" href="#url">

### Create Your Tour Outline

	/* Each tip is set within this <ol>. */
	/* This creates the order the tips are displayed */
	<ol id="chooseID">
	  /* data-id needs to be the same as the parent it will attach to */
	  <li data-target="#newHeader">Tip content...</li>
	  /* using 'data-title' lets you have custom title */
	  <li data-target="#parentElementID" data-title="Second Feature">Content...</li>
	  /* you can use 'data-placement' to define where the popup will appear */
	  <li data-target="#parentElementID" data-placement="bottom">Content...</li>
	</ol>

### Activate the tour

	/* Launching the tour when to page is loaded */
	<script type="text/javascript">
	  $(window).load(function() {
	    $(this).featureTour({
	      /* Options will go here */
	    });
	  });
	</script>
	
### Options

	/* Setting your options to override the defaults */
	$(this).featureTour({
	  'cookieMonster': true,           // true/false for whether cookies are used
	  'cookieName': 'myHomepageTour',  // choose your own cookie name
	  'cookieDomain': false,           // set to false or yoursite.com
	  'tipContent': '#tourContent'     // The ID of the <ol> used for content
	});

## GILD

Bootstrap Tour was made by [GILD](http://www.gild.com).

## MIT Open Source License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.