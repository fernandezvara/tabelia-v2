/*
 * jQuery Easing v1.3 - http://gsgd.co.uk/sandbox/jquery/easing/
 *
 * Uses the built in easing capabilities added In jQuery 1.1
 * to offer multiple easing options
 *
 * TERMS OF USE - jQuery Easing
 * 
 * Open source under the BSD License. 
 * 
 * Copyright © 2008 George McGinley Smith
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 * 
 * Redistributions of source code must retain the above copyright notice, this list of 
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list 
 * of conditions and the following disclaimer in the documentation and/or other materials 
 * provided with the distribution.
 * 
 * Neither the name of the author nor the names of contributors may be used to endorse 
 * or promote products derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
 * OF THE POSSIBILITY OF SUCH DAMAGE. 
 *
*/

// t: current time, b: begInnIng value, c: change In value, d: duration
jQuery.easing['jswing'] = jQuery.easing['swing'];

jQuery.extend( jQuery.easing,
{
	def: 'easeOutQuad',
	swing: function (x, t, b, c, d) {
		//alert(jQuery.easing.default);
		return jQuery.easing[jQuery.easing.def](x, t, b, c, d);
	},
	easeInQuad: function (x, t, b, c, d) {
		return c*(t/=d)*t + b;
	},
	easeOutQuad: function (x, t, b, c, d) {
		return -c *(t/=d)*(t-2) + b;
	},
	easeInOutQuad: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t + b;
		return -c/2 * ((--t)*(t-2) - 1) + b;
	},
	easeInCubic: function (x, t, b, c, d) {
		return c*(t/=d)*t*t + b;
	},
	easeOutCubic: function (x, t, b, c, d) {
		return c*((t=t/d-1)*t*t + 1) + b;
	},
	easeInOutCubic: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t*t + b;
		return c/2*((t-=2)*t*t + 2) + b;
	},
	easeInQuart: function (x, t, b, c, d) {
		return c*(t/=d)*t*t*t + b;
	},
	easeOutQuart: function (x, t, b, c, d) {
		return -c * ((t=t/d-1)*t*t*t - 1) + b;
	},
	easeInOutQuart: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
		return -c/2 * ((t-=2)*t*t*t - 2) + b;
	},
	easeInQuint: function (x, t, b, c, d) {
		return c*(t/=d)*t*t*t*t + b;
	},
	easeOutQuint: function (x, t, b, c, d) {
		return c*((t=t/d-1)*t*t*t*t + 1) + b;
	},
	easeInOutQuint: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
		return c/2*((t-=2)*t*t*t*t + 2) + b;
	},
	easeInSine: function (x, t, b, c, d) {
		return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
	},
	easeOutSine: function (x, t, b, c, d) {
		return c * Math.sin(t/d * (Math.PI/2)) + b;
	},
	easeInOutSine: function (x, t, b, c, d) {
		return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
	},
	easeInExpo: function (x, t, b, c, d) {
		return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
	},
	easeOutExpo: function (x, t, b, c, d) {
		return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
	},
	easeInOutExpo: function (x, t, b, c, d) {
		if (t==0) return b;
		if (t==d) return b+c;
		if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
		return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
	},
	easeInCirc: function (x, t, b, c, d) {
		return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
	},
	easeOutCirc: function (x, t, b, c, d) {
		return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
	},
	easeInOutCirc: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
		return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
	},
	easeInElastic: function (x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
	},
	easeOutElastic: function (x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
	},
	easeInOutElastic: function (x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
		return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
	},
	easeInBack: function (x, t, b, c, d, s) {
		if (s == undefined) s = 1.70158;
		return c*(t/=d)*t*((s+1)*t - s) + b;
	},
	easeOutBack: function (x, t, b, c, d, s) {
		if (s == undefined) s = 1.70158;
		return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
	},
	easeInOutBack: function (x, t, b, c, d, s) {
		if (s == undefined) s = 1.70158; 
		if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
		return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
	},
	easeInBounce: function (x, t, b, c, d) {
		return c - jQuery.easing.easeOutBounce (x, d-t, 0, c, d) + b;
	},
	easeOutBounce: function (x, t, b, c, d) {
		if ((t/=d) < (1/2.75)) {
			return c*(7.5625*t*t) + b;
		} else if (t < (2/2.75)) {
			return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
		} else if (t < (2.5/2.75)) {
			return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
		} else {
			return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
		}
	},
	easeInOutBounce: function (x, t, b, c, d) {
		if (t < d/2) return jQuery.easing.easeInBounce (x, t*2, 0, c, d) * .5 + b;
		return jQuery.easing.easeOutBounce (x, t*2-d, 0, c, d) * .5 + c*.5 + b;
	}
});

/*
 *
 * TERMS OF USE - EASING EQUATIONS
 * 
 * Open source under the BSD License. 
 * 
 * Copyright © 2001 Robert Penner
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 * 
 * Redistributions of source code must retain the above copyright notice, this list of 
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list 
 * of conditions and the following disclaimer in the documentation and/or other materials 
 * provided with the distribution.
 * 
 * Neither the name of the author nor the names of contributors may be used to endorse 
 * or promote products derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
 * OF THE POSSIBILITY OF SUCH DAMAGE. 
 *
 */


/*!
 * jQuery 2d Transform v0.9.3
 * http://wiki.github.com/heygrady/transform/
 *
 * Copyright 2010, Grady Kuhnline
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 * 
 * Date: Sat Dec 4 15:46:09 2010 -0800
 */
///////////////////////////////////////////////////////
// Transform
///////////////////////////////////////////////////////
(function($, window, document, undefined) {
	/**
	 * @var Regex identify the matrix filter in IE
	 */
	var rmatrix = /progid:DXImageTransform\.Microsoft\.Matrix\(.*?\)/,
		rfxnum = /^([\+\-]=)?([\d+.\-]+)(.*)$/,
		rperc = /%/;

	// Steal some code from Modernizr
	var m = document.createElement( 'modernizr' ),
		m_style = m.style;

	function stripUnits(arg) {
		return parseFloat(arg);
	}

	/**
	 * Find the prefix that this browser uses
	 */	
	function getVendorPrefix() {
		var property = {
			transformProperty : '',
			MozTransform : '-moz-',
			WebkitTransform : '-webkit-',
			OTransform : '-o-',
			msTransform : '-ms-'
		};
		for (var p in property) {
			if (typeof m_style[p] != 'undefined') {
				return property[p];
			}
		}
		return null;
	}

	function supportCssTransforms() {
		if (typeof(window.Modernizr) !== 'undefined') {
			return Modernizr.csstransforms;
		}

		var props = [ 'transformProperty', 'WebkitTransform', 'MozTransform', 'OTransform', 'msTransform' ];
		for ( var i in props ) {
			if ( m_style[ props[i] ] !== undefined  ) {
				return true;
			}
		}
	}

	// Capture some basic properties
	var vendorPrefix			= getVendorPrefix(),
		transformProperty		= vendorPrefix !== null ? vendorPrefix + 'transform' : false,
		transformOriginProperty	= vendorPrefix !== null ? vendorPrefix + 'transform-origin' : false;

	// store support in the jQuery Support object
	$.support.csstransforms = supportCssTransforms();

	// IE9 public preview 6 requires the DOM names
	if (vendorPrefix == '-ms-') {
		transformProperty = 'msTransform';
		transformOriginProperty = 'msTransformOrigin';
	}

	/**
	 * Class for creating cross-browser transformations
	 * @constructor
	 */
	$.extend({
		transform: function(elem) {
			// Cache the transform object on the element itself
			elem.transform = this;

			/**
			 * The element we're working with
			 * @var jQueryCollection
			 */
			this.$elem = $(elem);

			/**
			 * Remember the matrix we're applying to help the safeOuterLength func
			 */
			this.applyingMatrix = false;
			this.matrix = null;

			/**
			 * Remember the css height and width to save time
			 * This is only really used in IE
			 * @var Number
			 */
			this.height = null;
			this.width = null;
			this.outerHeight = null;
			this.outerWidth = null;

			/**
			 * We need to know the box-sizing in IE for building the outerHeight and outerWidth
			 * @var string
			 */
			this.boxSizingValue = null;
			this.boxSizingProperty = null;

			this.attr = null;
			this.transformProperty = transformProperty;
			this.transformOriginProperty = transformOriginProperty;
		}
	});

	$.extend($.transform, {
		/**
		 * @var Array list of all valid transform functions
		 */
		funcs: ['matrix', 'origin', 'reflect', 'reflectX', 'reflectXY', 'reflectY', 'rotate', 'scale', 'scaleX', 'scaleY', 'skew', 'skewX', 'skewY', 'translate', 'translateX', 'translateY']
	});

	/**
	 * Create Transform as a jQuery plugin
	 * @param Object funcs
	 * @param Object options
	 */
	$.fn.transform = function(funcs, options) {
		return this.each(function() {
			var t = this.transform || new $.transform(this);
			if (funcs) {
				t.exec(funcs, options);
			}
		});
	};

	$.transform.prototype = {
		/**
		 * Applies all of the transformations
		 * @param Object funcs
		 * @param Object options
		 * forceMatrix - uses the matrix in all browsers
		 * preserve - tries to preserve the values from previous runs
		 */
		exec: function(funcs, options) {
			// extend options
			options = $.extend(true, {
				forceMatrix: false,
				preserve: false
			}, options);

			// preserve the funcs from the previous run
			this.attr = null;
			if (options.preserve) {
				funcs = $.extend(true, this.getAttrs(true, true), funcs);
			} else {
				funcs = $.extend(true, {}, funcs); // copy the object to prevent weirdness
			}

			// Record the custom attributes on the element itself
			this.setAttrs(funcs);

			// apply the funcs
			if ($.support.csstransforms && !options.forceMatrix) {
				// CSS3 is supported
				return this.execFuncs(funcs);
			} else if ($.browser.msie || ($.support.csstransforms && options.forceMatrix)) {
				// Internet Explorer or Forced matrix
				return this.execMatrix(funcs);
			}
			return false;
		},

		/**
		 * Applies all of the transformations as functions
		 * @param Object funcs
		 */
		execFuncs: function(funcs) {
			var values = [];

			// construct a CSS string
			for (var func in funcs) {
				// handle origin separately
				if (func == 'origin') {
					this[func].apply(this, $.isArray(funcs[func]) ? funcs[func] : [funcs[func]]);
				} else if ($.inArray(func, $.transform.funcs) !== -1) {
					values.push(this.createTransformFunc(func, funcs[func]));
				}
			}
			this.$elem.css(transformProperty, values.join(' '));
			return true;
		},

		/**
		 * Applies all of the transformations as a matrix
		 * @param Object funcs
		 */
		execMatrix: function(funcs) {
			var matrix,
				tempMatrix,
				args;

			var elem = this.$elem[0],
				_this = this;
			function normalPixels(val, i) {
				if (rperc.test(val)) {
					// this really only applies to translation
					return parseFloat(val) / 100 * _this['safeOuter' + (i ? 'Height' : 'Width')]();
				}
				return toPx(elem, val);
			}

			var rtranslate = /translate[X|Y]?/,
				trans = [];

			for (var func in funcs) {
				switch ($.type(funcs[func])) {
					case 'array': args = funcs[func]; break;
					case 'string': args = $.map(funcs[func].split(','), $.trim); break;
					default: args = [funcs[func]];
				}

				if ($.matrix[func]) {

					if ($.cssAngle[func]) {
						// normalize on degrees
						args = $.map(args, $.angle.toDegree);						
					} else if (!$.cssNumber[func]) {
						// normalize to pixels
						args = $.map(args, normalPixels);
					} else {
						// strip units
						args = $.map(args, stripUnits);
					}

					tempMatrix = $.matrix[func].apply(this, args);
					if (rtranslate.test(func)) {
						//defer translation
						trans.push(tempMatrix);
					} else {
						matrix = matrix ? matrix.x(tempMatrix) : tempMatrix;
					}
				} else if (func == 'origin') {
					this[func].apply(this, args);
				}
			}

			// check that we have a matrix
			matrix = matrix || $.matrix.identity();

			// Apply translation
			$.each(trans, function(i, val) { matrix = matrix.x(val); });

			// pull out the relevant values
			var a = parseFloat(matrix.e(1,1).toFixed(6)),
				b = parseFloat(matrix.e(2,1).toFixed(6)),
				c = parseFloat(matrix.e(1,2).toFixed(6)),
				d = parseFloat(matrix.e(2,2).toFixed(6)),
				tx = matrix.rows === 3 ? parseFloat(matrix.e(1,3).toFixed(6)) : 0,
				ty = matrix.rows === 3 ? parseFloat(matrix.e(2,3).toFixed(6)) : 0;

			//apply the transform to the element
			if ($.support.csstransforms && vendorPrefix === '-moz-') {
				// -moz-
				this.$elem.css(transformProperty, 'matrix(' + a + ', ' + b + ', ' + c + ', ' + d + ', ' + tx + 'px, ' + ty + 'px)');
			} else if ($.support.csstransforms) {
				// -webkit, -o-, w3c
				// NOTE: WebKit and Opera don't allow units on the translate variables
				this.$elem.css(transformProperty, 'matrix(' + a + ', ' + b + ', ' + c + ', ' + d + ', ' + tx + ', ' + ty + ')');
			} else if ($.browser.msie) {
				// IE requires the special transform Filter

				//TODO: Use Nearest Neighbor during animation FilterType=\'nearest neighbor\'
				var filterType = ', FilterType=\'nearest neighbor\''; //bilinear
				var style = this.$elem[0].style;
				var matrixFilter = 'progid:DXImageTransform.Microsoft.Matrix(' +
						'M11=' + a + ', M12=' + c + ', M21=' + b + ', M22=' + d +
						', sizingMethod=\'auto expand\'' + filterType + ')';
				var filter = style.filter || $.curCSS( this.$elem[0], "filter" ) || "";
				style.filter = rmatrix.test(filter) ? filter.replace(rmatrix, matrixFilter) : filter ? filter + ' ' + matrixFilter : matrixFilter;

				// Let's know that we're applying post matrix fixes and the height/width will be static for a bit
				this.applyingMatrix = true;
				this.matrix = matrix;

				// IE can't set the origin or translate directly
				this.fixPosition(matrix, tx, ty);

				this.applyingMatrix = false;
				this.matrix = null;
			}
			return true;
		},

		/**
		 * Sets the transform-origin
		 * This really needs to be percentages
		 * @param Number x length
		 * @param Number y length
		 */
		origin: function(x, y) {
			// use CSS in supported browsers
			if ($.support.csstransforms) {
				if (typeof y === 'undefined') {
					this.$elem.css(transformOriginProperty, x);
				} else {
					this.$elem.css(transformOriginProperty, x + ' ' + y);
				}
				return true;
			}

			// correct for keyword lengths
			switch (x) {
				case 'left': x = '0'; break;
				case 'right': x = '100%'; break;
				case 'center': // no break
				case undefined: x = '50%';
			}
			switch (y) {
				case 'top': y = '0'; break;
				case 'bottom': y = '100%'; break;
				case 'center': // no break
				case undefined: y = '50%'; //TODO: does this work?
			}

			// store mixed values with units, assumed pixels
			this.setAttr('origin', [
				rperc.test(x) ? x : toPx(this.$elem[0], x) + 'px',
				rperc.test(y) ? y : toPx(this.$elem[0], y) + 'px'
			]);
			//console.log(this.getAttr('origin'));
			return true;
		},

		/**
		 * Create a function suitable for a CSS value
		 * @param string func
		 * @param Mixed value
		 */
		createTransformFunc: function(func, value) {
			if (func.substr(0, 7) === 'reflect') {
				// let's fake reflection, false value 
				// falsey sets an identity matrix
				var m = value ? $.matrix[func]() : $.matrix.identity();
				return 'matrix(' + m.e(1,1) + ', ' + m.e(2,1) + ', ' + m.e(1,2) + ', ' + m.e(2,2) + ', 0, 0)';
			}

			//value = _correctUnits(func, value);

			if (func == 'matrix') {
				if (vendorPrefix === '-moz-') {
					value[4] = value[4] ? value[4] + 'px' : 0;
					value[5] = value[5] ? value[5] + 'px' : 0;
				}
			}
			return func + '(' + ($.isArray(value) ? value.join(', ') : value) + ')';
		},

		/**
		 * @param Matrix matrix
		 * @param Number tx
		 * @param Number ty
		 * @param Number height
		 * @param Number width
		 */
		fixPosition: function(matrix, tx, ty, height, width) {
			// now we need to fix it!
			var	calc = new $.matrix.calc(matrix, this.safeOuterHeight(), this.safeOuterWidth()),
				origin = this.getAttr('origin'); // mixed percentages and px

			// translate a 0, 0 origin to the current origin
			var offset = calc.originOffset(new $.matrix.V2(
				rperc.test(origin[0]) ? parseFloat(origin[0])/100*calc.outerWidth : parseFloat(origin[0]),
				rperc.test(origin[1]) ? parseFloat(origin[1])/100*calc.outerHeight : parseFloat(origin[1])
			));

			// IE glues the top-most and left-most pixels of the transformed object to top/left of the original object
			//TODO: This seems wrong in the calculations
			var sides = calc.sides();

			// Protect against an item that is already positioned
			var cssPosition = this.$elem.css('position');
			if (cssPosition == 'static') {
				cssPosition = 'relative';
			}

			//TODO: if the element is already positioned, we should attempt to respect it (somehow)
			//NOTE: we could preserve our offset top and left in an attr on the elem
			var pos = {top: 0, left: 0};

			// Approximates transform-origin, tx, and ty
			var css = {
				'position': cssPosition,
				'top': (offset.top + ty + sides.top + pos.top) + 'px',
				'left': (offset.left + tx + sides.left + pos.left) + 'px',
				'zoom': 1
			};

			this.$elem.css(css);
		}
	};

	/**
	 * Ensure that values have the appropriate units on them
	 * @param string func
	 * @param Mixed value
	 */
	function toPx(elem, val) {
		var parts = rfxnum.exec($.trim(val));

		if (parts[3] && parts[3] !== 'px') {
			var prop = 'paddingBottom',
				orig = $.style( elem, prop );

			$.style( elem, prop, val );
			val = cur( elem, prop );
			$.style( elem, prop, orig );
			return val;
		}
		return parseFloat( val );
	}

	function cur(elem, prop) {
		if ( elem[prop] != null && (!elem.style || elem.style[prop] == null) ) {
			return elem[ prop ];
		}

		var r = parseFloat( $.css( elem, prop ) );
		return r && r > -10000 ? r : 0;
	}
})(jQuery, this, this.document);


///////////////////////////////////////////////////////
// Safe Outer Length
///////////////////////////////////////////////////////
(function($, window, document, undefined) {
	$.extend($.transform.prototype, {
		/**
		 * @param void
		 * @return Number
		 */
		safeOuterHeight: function() {
			return this.safeOuterLength('height');
		},

		/**
		 * @param void
		 * @return Number
		 */
		safeOuterWidth: function() {
			return this.safeOuterLength('width');
		},

		/**
		 * Returns reliable outer dimensions for an object that may have been transformed.
		 * Only use this if the matrix isn't handy
		 * @param String dim height or width
		 * @return Number
		 */
		safeOuterLength: function(dim) {
			var funcName = 'outer' + (dim == 'width' ? 'Width' : 'Height');

			if (!$.support.csstransforms && $.browser.msie) {
				// make the variables more generic
				dim = dim == 'width' ? 'width' : 'height';

				// if we're transforming and have a matrix; we can shortcut.
				// the true outerHeight is the transformed outerHeight divided by the ratio.
				// the ratio is equal to the height of a 1px by 1px box that has been transformed by the same matrix.
				if (this.applyingMatrix && !this[funcName] && this.matrix) {
					// calculate and return the correct size
					var calc = new $.matrix.calc(this.matrix, 1, 1),
						ratio = calc.offset(),
						length = this.$elem[funcName]() / ratio[dim];
					this[funcName] = length;

					return length;
				} else if (this.applyingMatrix && this[funcName]) {
					// return the cached calculation
					return this[funcName];
				}

				// map dimensions to box sides			
				var side = {
					height: ['top', 'bottom'],
					width: ['left', 'right']
				};

				// setup some variables
				var elem = this.$elem[0],
					outerLen = parseFloat($.curCSS(elem, dim, true)), //TODO: this can be cached on animations that do not animate height/width
					boxSizingProp = this.boxSizingProperty,
					boxSizingValue = this.boxSizingValue;

				// IE6 && IE7 will never have a box-sizing property, so fake it
				if (!this.boxSizingProperty) {
					boxSizingProp = this.boxSizingProperty = _findBoxSizingProperty() || 'box-sizing';
					boxSizingValue = this.boxSizingValue = this.$elem.css(boxSizingProp) || 'content-box';
				}

				// return it immediately if we already know it
				if (this[funcName] && this[dim] == outerLen) {
					return this[funcName];
				} else {
					this[dim] = outerLen;
				}

				// add in the padding and border
				if (boxSizingProp && (boxSizingValue == 'padding-box' || boxSizingValue == 'content-box')) {
					outerLen += parseFloat($.curCSS(elem, 'padding-' + side[dim][0], true)) || 0 +
								  parseFloat($.curCSS(elem, 'padding-' + side[dim][1], true)) || 0;
				}
				if (boxSizingProp && boxSizingValue == 'content-box') {
					outerLen += parseFloat($.curCSS(elem, 'border-' + side[dim][0] + '-width', true)) || 0 +
								  parseFloat($.curCSS(elem, 'border-' + side[dim][1] + '-width', true)) || 0;
				}

				// remember and return the outerHeight
				this[funcName] = outerLen;
				return outerLen;
			}
			return this.$elem[funcName]();
		}
	});

	/**
	 * Determine the correct property for checking the box-sizing property
	 * @param void
	 * @return string
	 */
	var _boxSizingProperty = null;
	function _findBoxSizingProperty () {
		if (_boxSizingProperty) {
			return _boxSizingProperty;
		} 

		var property = {
				boxSizing : 'box-sizing',
				MozBoxSizing : '-moz-box-sizing',
				WebkitBoxSizing : '-webkit-box-sizing',
				OBoxSizing : '-o-box-sizing'
			},
			elem = document.body;

		for (var p in property) {
			if (typeof elem.style[p] != 'undefined') {
				_boxSizingProperty = property[p];
				return _boxSizingProperty;
			}
		}
		return null;
	}
})(jQuery, this, this.document);


///////////////////////////////////////////////////////
// Attr
///////////////////////////////////////////////////////
(function($, window, document, undefined) {
	var rfuncvalue = /([\w\-]*?)\((.*?)\)/g, // with values
		attr = 'data-transform',
		rspace = /\s/,
		rcspace = /,\s?/;

	$.extend($.transform.prototype, {		
		/**
		 * This overrides all of the attributes
		 * @param Object funcs a list of transform functions to store on this element
		 * @return void
		 */
		setAttrs: function(funcs) {
			var string = '',
				value;
			for (var func in funcs) {
				value = funcs[func];
				if ($.isArray(value)) {
					value = value.join(', ');
				}
				string += ' ' + func + '(' + value + ')'; 
			}
			this.attr = $.trim(string);
			this.$elem.attr(attr, this.attr);
		},

		/**
		 * This sets only a specific atribute
		 * @param string func name of a transform function
		 * @param mixed value with proper units
		 * @return void
		 */
		setAttr: function(func, value) {
			// stringify the value
			if ($.isArray(value)) {
				value = value.join(', ');
			}

			// pull from a local variable to look it up
			var transform = this.attr || this.$elem.attr(attr);
			if (!transform || transform.indexOf(func) == -1) {
				// we don't have any existing values, save it
				// we don't have this function yet, save it
				this.attr = $.trim(transform + ' ' + func + '(' + value + ')');
				this.$elem.attr(attr, this.attr);
			} else {
				// replace the existing value
				var funcs = [],	parts;

				// regex split
				rfuncvalue.lastIndex = 0; // reset the regex pointer
				while (parts = rfuncvalue.exec(transform)) {
					if (func == parts[1]) {
						funcs.push(func + '(' + value + ')');
					} else {
						funcs.push(parts[0]);
					}
				}
				this.attr = funcs.join(' ');
				this.$elem.attr(attr, this.attr);
			}
		},

		/**
		 * @return Object
		 */
		getAttrs: function() {
			var transform = this.attr || this.$elem.attr(attr);
			if (!transform) {
				// We don't have any existing values, return empty object
				return {};
			}

			// replace the existing value
			var attrs = {}, parts, value;

			rfuncvalue.lastIndex = 0; // reset the regex pointer
			while ((parts = rfuncvalue.exec(transform)) !== null) {
				if (parts) {
					value = parts[2].split(rcspace);
					attrs[parts[1]] = value.length == 1 ? value[0] : value;
				}
			}
			return attrs;
		},

		/**
		 * @param String func 
		 * @return mixed
		 */
		getAttr: function(func) {
			var attrs = this.getAttrs();
			if (typeof attrs[func] !== 'undefined') {
				return attrs[func];
			}

			//TODO: move the origin to a function
			if (func === 'origin' && $.support.csstransforms) {
				// supported browsers return percentages always
				return this.$elem.css(this.transformOriginProperty).split(rspace);
			} else if (func === 'origin') {
				// just force IE to also return a percentage
				return ['50%', '50%'];
			}

			return $.cssDefault[func] || 0;
		}
	});

	// Define 
	if (typeof($.cssAngle) == 'undefined') {
		$.cssAngle = {};
	}
	$.extend($.cssAngle, {
		rotate: true,
		skew: true,
		skewX: true,
		skewY: true
	});

	// Define default values
	if (typeof($.cssDefault) == 'undefined') {
		$.cssDefault = {};
	}

	$.extend($.cssDefault, {
		scale: [1, 1],
		scaleX: 1,
		scaleY: 1,
		matrix: [1, 0, 0, 1, 0, 0],
		origin: ['50%', '50%'], // TODO: allow this to be a function, like get
		reflect: [1, 0, 0, 1, 0, 0],
		reflectX: [1, 0, 0, 1, 0, 0],
		reflectXY: [1, 0, 0, 1, 0, 0],
		reflectY: [1, 0, 0, 1, 0, 0]
	});

	// Define functons with multiple values
	if (typeof($.cssMultipleValues) == 'undefined') {
		$.cssMultipleValues = {};
	}
	$.extend($.cssMultipleValues, {
		matrix: 6,
		origin: {
			length: 2,
			duplicate: true
		},
		reflect: 6,
		reflectX: 6,
		reflectXY: 6,
		reflectY: 6,
		scale: {
			length: 2,
			duplicate: true
		},
		skew: 2,
		translate: 2
	});

	// specify unitless funcs
	$.extend($.cssNumber, {
		matrix: true,
		reflect: true,
		reflectX: true,
		reflectXY: true,
		reflectY: true,
		scale: true,
		scaleX: true,
		scaleY: true
	});

	// override all of the css functions
	$.each($.transform.funcs, function(i, func) {
		$.cssHooks[func] = {
			set: function(elem, value) {
				var transform = elem.transform || new $.transform(elem),
					funcs = {};
				funcs[func] = value;
				transform.exec(funcs, {preserve: true});
			},
			get: function(elem, computed) {
				var transform = elem.transform || new $.transform(elem);
				return transform.getAttr(func);
			}
		};
	});

	// Support Reflection animation better by returning a matrix
	$.each(['reflect', 'reflectX', 'reflectXY', 'reflectY'], function(i, func) {
		$.cssHooks[func].get = function(elem, computed) {
			var transform = elem.transform || new $.transform(elem);
			return transform.getAttr('matrix') || $.cssDefault[func];
		};
	});
})(jQuery, this, this.document);
///////////////////////////////////////////////////////
// Animation
///////////////////////////////////////////////////////
(function($, window, document, undefined) {
	/**
	 * @var Regex looks for units on a string
	 */
	var rfxnum = /^([+\-]=)?([\d+.\-]+)(.*)$/;

	/**
	 * Doctors prop values in the event that they contain spaces
	 * @param Object prop
	 * @param String speed
	 * @param String easing
	 * @param Function callback
	 * @return bool
	 */
	var _animate = $.fn.animate;
	$.fn.animate = function( prop, speed, easing, callback ) {
		var optall = $.speed(speed, easing, callback),
			mv = $.cssMultipleValues;

		// Speed always creates a complete function that must be reset
		optall.complete = optall.old;

		// Capture multiple values
		if (!$.isEmptyObject(prop)) {
			if (typeof optall.original === 'undefined') {
				optall.original = {};
			}
			$.each( prop, function( name, val ) {
				if (mv[name]
					|| $.cssAngle[name]
					|| (!$.cssNumber[name] && $.inArray(name, $.transform.funcs) !== -1)) {

					// Handle special easing
					var specialEasing = null;
					if (jQuery.isArray(prop[name])) {
						var mvlen = 1, len = val.length;
						if (mv[name]) {
							mvlen = (typeof mv[name].length === 'undefined' ? mv[name] : mv[name].length);
						}
						if ( len > mvlen
							|| (len < mvlen && len == 2)
							|| (len == 2 && mvlen == 2 && isNaN(parseFloat(val[len - 1])))) {

							specialEasing = val[len - 1];
							val.splice(len - 1, 1);
						}
					}

					// Store the original values onto the optall
					optall.original[name] = val.toString();

					// reduce to a unitless number (to trick animate)
					prop[name] = parseFloat(val);
				}
			} );
		}

		//NOTE: we edited prop above to trick animate
		//NOTE: we pre-convert to an optall so we can doctor it
		return _animate.apply(this, [arguments[0], optall]);
	};

	var prop = 'paddingBottom';
	function cur(elem, prop) {
		if ( elem[prop] != null && (!elem.style || elem.style[prop] == null) ) {
			//return elem[ prop ];
		}

		var r = parseFloat( $.css( elem, prop ) );
		return r && r > -10000 ? r : 0;
	}

	var _custom = $.fx.prototype.custom;
	$.fx.prototype.custom = function(from, to, unit) {
		var multiple = $.cssMultipleValues[this.prop],
			angle = $.cssAngle[this.prop];

		//TODO: simply check for the existence of CSS Hooks?
		if (multiple || (!$.cssNumber[this.prop] && $.inArray(this.prop, $.transform.funcs) !== -1)) {
			this.values = [];

			if (!multiple) {
				multiple = 1;
			}

			// Pull out the known values
			var values = this.options.original[this.prop],
				currentValues = $(this.elem).css(this.prop),
				defaultValues = $.cssDefault[this.prop] || 0;

			// make sure the current css value is an array
			if (!$.isArray(currentValues)) {
				currentValues = [currentValues];
			}

			// make sure the new values are an array
			if (!$.isArray(values)) {
				if ($.type(values) === 'string') {
					values = values.split(',');
				} else {
					values = [values];
				}
			}

			// make sure we have enough new values
			var length = multiple.length || multiple, i = 0;
			while (values.length < length) {
				values.push(multiple.duplicate ? values[0] : defaultValues[i] || 0);
				i++;
			}

			// calculate a start, end and unit for each new value
			var start, parts, end, //unit,
				fx = this,
				transform = fx.elem.transform;
				orig = $.style(fx.elem, prop);

			$.each(values, function(i, val) {
				// find a sensible start value
				if (currentValues[i]) {
					start = currentValues[i];
				} else if (defaultValues[i] && !multiple.duplicate) {
					start = defaultValues[i];
				} else if (multiple.duplicate) {
					start = currentValues[0];
				} else {
					start = 0;
				}

				// Force the correct unit on the start
				if (angle) {
					start = $.angle.toDegree(start);
				} else if (!$.cssNumber[fx.prop]) {
					parts = rfxnum.exec($.trim(start));
					if (parts[3] && parts[3] !== 'px') {
						if (parts[3] === '%') {
							start = parseFloat( parts[2] ) / 100 * transform['safeOuter' + (i ? 'Height' : 'Width')]();
						} else {
							$.style( fx.elem, prop, start);
							start = cur(fx.elem, prop);
							$.style( fx.elem, prop, orig);
						}
					}
				}
				start = parseFloat(start);

				// parse the value with a regex
				parts = rfxnum.exec($.trim(val));

				if (parts) {
					// we found a sensible value and unit
					end = parseFloat( parts[2] );
					unit = parts[3] || "px"; //TODO: change to an appropriate default unit

					if (angle) {
						end = $.angle.toDegree(end + unit);
						unit = 'deg';
					} else if (!$.cssNumber[fx.prop] && unit === '%') {
						start = (start / transform['safeOuter' + (i ? 'Height' : 'Width')]()) * 100;
					} else if (!$.cssNumber[fx.prop] && unit !== 'px') {
						$.style( fx.elem, prop, (end || 1) + unit);
						start = ((end || 1) / cur(fx.elem, prop)) * start;
						$.style( fx.elem, prop, orig);
					}

					// If a +=/-= token was provided, we're doing a relative animation
					if (parts[1]) {
						end = ((parts[1] === "-=" ? -1 : 1) * end) + start;
					}
				} else {
					// I don't know when this would happen
					end = val;
					unit = ''; 
				}

				// Save the values
				fx.values.push({
					start: start,
					end: end,
					unit: unit
				});				
			});
		}
		return _custom.apply(this, arguments);
	};

	/**
	 * Animates a multi value attribute
	 * @param Object fx
	 * @return null
	 */
	$.fx.multipleValueStep = {
		_default: function(fx) {
			$.each(fx.values, function(i, val) {
				fx.values[i].now = val.start + ((val.end - val.start) * fx.pos);
			});
		}
	};
	$.each(['matrix', 'reflect', 'reflectX', 'reflectXY', 'reflectY'], function(i, func) {
		$.fx.multipleValueStep[func] = function(fx) {
			var d = fx.decomposed,
				$m = $.matrix;
				m = $m.identity();

			d.now = {};

			// increment each part of the decomposition and recompose it		
			$.each(d.start, function(k) {				
				// calculate the current value
				d.now[k] = parseFloat(d.start[k]) + ((parseFloat(d.end[k]) - parseFloat(d.start[k])) * fx.pos);

				// skip functions that won't affect the transform
				if (((k === 'scaleX' || k === 'scaleY') && d.now[k] === 1) ||
					(k !== 'scaleX' && k !== 'scaleY' && d.now[k] === 0)) {
					return true;
				}

				// calculating
				m = m.x($m[k](d.now[k]));
			});

			// save the correct matrix values for the value of now
			var val;
			$.each(fx.values, function(i) {
				switch (i) {
					case 0: val = parseFloat(m.e(1, 1).toFixed(6)); break;
					case 1: val = parseFloat(m.e(2, 1).toFixed(6)); break;
					case 2: val = parseFloat(m.e(1, 2).toFixed(6)); break;
					case 3: val = parseFloat(m.e(2, 2).toFixed(6)); break;
					case 4: val = parseFloat(m.e(1, 3).toFixed(6)); break;
					case 5: val = parseFloat(m.e(2, 3).toFixed(6)); break;
				}
				fx.values[i].now = val;
			});
		};
	});
	/**
	 * Step for animating tranformations
	 */
	$.each($.transform.funcs, function(i, func) {
		$.fx.step[func] = function(fx) {
			var transform = fx.elem.transform || new $.transform(fx.elem),
				funcs = {};

			if ($.cssMultipleValues[func] || (!$.cssNumber[func] && $.inArray(func, $.transform.funcs) !== -1)) {
				($.fx.multipleValueStep[fx.prop] || $.fx.multipleValueStep._default)(fx);
				funcs[fx.prop] = [];
				$.each(fx.values, function(i, val) {
					funcs[fx.prop].push(val.now + ($.cssNumber[fx.prop] ? '' : val.unit));
				});
			} else {
				funcs[fx.prop] = fx.now + ($.cssNumber[fx.prop] ? '' : fx.unit);
			}

			transform.exec(funcs, {preserve: true});
		};
	});

	// Support matrix animation
	$.each(['matrix', 'reflect', 'reflectX', 'reflectXY', 'reflectY'], function(i, func) {
		$.fx.step[func] = function(fx) {
			var transform = fx.elem.transform || new $.transform(fx.elem),
				funcs = {};

			if (!fx.initialized) {
				fx.initialized = true;

				// Reflections need a sensible end value set
				if (func !== 'matrix') {
					var values = $.matrix[func]().elements;
					var val;
					$.each(fx.values, function(i) {
						switch (i) {
							case 0: val = values[0]; break;
							case 1: val = values[2]; break;
							case 2: val = values[1]; break;
							case 3: val = values[3]; break;
							default: val = 0;
						}
						fx.values[i].end = val;
					});
				}

				// Decompose the start and end
				fx.decomposed = {};
				var v = fx.values;

				fx.decomposed.start = $.matrix.matrix(v[0].start, v[1].start, v[2].start, v[3].start, v[4].start, v[5].start).decompose();
				fx.decomposed.end = $.matrix.matrix(v[0].end, v[1].end, v[2].end, v[3].end, v[4].end, v[5].end).decompose();
			}

			($.fx.multipleValueStep[fx.prop] || $.fx.multipleValueStep._default)(fx);
			funcs.matrix = [];
			$.each(fx.values, function(i, val) {
				funcs.matrix.push(val.now);
			});

			transform.exec(funcs, {preserve: true});
		};
	});
})(jQuery, this, this.document);
///////////////////////////////////////////////////////
// Angle
///////////////////////////////////////////////////////
(function($, window, document, undefined) {
	/**
	 * Converting a radian to a degree
	 * @const
	 */
	var RAD_DEG = 180/Math.PI;

	/**
	 * Converting a radian to a grad
	 * @const
	 */
	var RAD_GRAD = 200/Math.PI;

	/**
	 * Converting a degree to a radian
	 * @const
	 */
	var DEG_RAD = Math.PI/180;

	/**
	 * Converting a degree to a grad
	 * @const
	 */
	var DEG_GRAD = 2/1.8;

	/**
	 * Converting a grad to a degree
	 * @const
	 */
	var GRAD_DEG = 0.9;

	/**
	 * Converting a grad to a radian
	 * @const
	 */
	var GRAD_RAD = Math.PI/200;


	var rfxnum = /^([+\-]=)?([\d+.\-]+)(.*)$/;

	/**
	 * Functions for converting angles
	 * @var Object
	 */
	$.extend({
		angle: {
			/**
			 * available units for an angle
			 * @var Regex
			 */
			runit: /(deg|g?rad)/,

			/**
			 * Convert a radian into a degree
			 * @param Number rad
			 * @return Number
			 */
			radianToDegree: function(rad) {
				return rad * RAD_DEG;
			},

			/**
			 * Convert a radian into a degree
			 * @param Number rad
			 * @return Number
			 */
			radianToGrad: function(rad) {
				return rad * RAD_GRAD;
			},

			/**
			 * Convert a degree into a radian
			 * @param Number deg
			 * @return Number
			 */
			degreeToRadian: function(deg) {
				return deg * DEG_RAD;
			},

			/**
			 * Convert a degree into a radian
			 * @param Number deg
			 * @return Number
			 */
			degreeToGrad: function(deg) {
				return deg * DEG_GRAD;
			},

			/**
			 * Convert a grad into a degree
			 * @param Number grad
			 * @return Number
			 */
			gradToDegree: function(grad) {
				return grad * GRAD_DEG;
			},

			/**
			 * Convert a grad into a radian
			 * @param Number grad
			 * @return Number
			 */
			gradToRadian: function(grad) {
				return grad * GRAD_RAD;
			},

			/**
			 * Convert an angle with a unit to a degree
			 * @param String val angle with a unit
			 * @return Number
			 */
			toDegree: function (val) {
				var parts = rfxnum.exec(val);
				if (parts) {
					val = parseFloat( parts[2] );
					switch (parts[3] || 'deg') {
						case 'grad':
							val = $.angle.gradToDegree(val);
							break;
						case 'rad':
							val = $.angle.radianToDegree(val);
							break;
					}
					return val;
				}
				return 0;
			}
		}
	});
})(jQuery, this, this.document);
///////////////////////////////////////////////////////
// Matrix
///////////////////////////////////////////////////////
(function($, window, document, undefined) {
	/**
	 * Matrix object for creating matrices relevant for 2d Transformations
	 * @var Object
	 */
	if (typeof($.matrix) == 'undefined') {
		$.extend({
			matrix: {}
		});
	}
	var $m = $.matrix;

	$.extend( $m, {
		/**
		 * A 2-value vector
		 * @param Number x
		 * @param Number y
		 * @constructor
		 */
		V2: function(x, y){
			if ($.isArray(arguments[0])) {
				this.elements = arguments[0].slice(0, 2);
			} else {
				this.elements = [x, y];
			}
			this.length = 2;
		},

		/**
		 * A 2-value vector
		 * @param Number x
		 * @param Number y
		 * @param Number z
		 * @constructor
		 */
		V3: function(x, y, z){
			if ($.isArray(arguments[0])) {
				this.elements = arguments[0].slice(0, 3);
			} else {
				this.elements = [x, y, z];
			}
			this.length = 3;
		},

		/**
		 * A 2x2 Matrix, useful for 2D-transformations without translations
		 * @param Number mn
		 * @constructor
		 */
		M2x2: function(m11, m12, m21, m22) {
			if ($.isArray(arguments[0])) {
				this.elements = arguments[0].slice(0, 4);
			} else {
				this.elements = Array.prototype.slice.call(arguments).slice(0, 4);
			}
			this.rows = 2;
			this.cols = 2;
		},

		/**
		 * A 3x3 Matrix, useful for 3D-transformations without translations
		 * @param Number mn
		 * @constructor
		 */
		M3x3: function(m11, m12, m13, m21, m22, m23, m31, m32, m33) {
			if ($.isArray(arguments[0])) {
				this.elements = arguments[0].slice(0, 9);
			} else {
				this.elements = Array.prototype.slice.call(arguments).slice(0, 9);
			}
			this.rows = 3;
			this.cols = 3;
		}
	});

	/** generic matrix prototype */
	var Matrix = {
		/**
		 * Return a specific element from the matrix
		 * @param Number row where 1 is the 0th row
		 * @param Number col where 1 is the 0th column
		 * @return Number
		 */
		e: function(row, col) {
			var rows = this.rows,
				cols = this.cols;

			// return 0 on nonsense rows and columns
			if (row > rows || col > rows || row < 1 || col < 1) {
				return 0;
			}

			return this.elements[(row - 1) * cols + col - 1];
		},

		/**
		 * Taken from Zoomooz
	     * https://github.com/jaukia/zoomooz/blob/c7a37b9a65a06ba730bd66391bbd6fe8e55d3a49/js/jquery.zoomooz.js
		 */
		decompose: function() {
			var a = this.e(1, 1),
				b = this.e(2, 1),
				c = this.e(1, 2),
				d = this.e(2, 2),
				e = this.e(1, 3),
				f = this.e(2, 3);

			// In case the matrix can't be decomposed
			if (Math.abs(a * d - b * c) < 0.01) {
				return {
					rotate: 0 + 'deg',
					skewX: 0 + 'deg',
					scaleX: 1,
					scaleY: 1,
					translateX: 0 + 'px',
					translateY: 0 + 'px'
				};
			}

			// Translate is easy
			var tx = e, ty = f;

			// factor out the X scale
			var sx = Math.sqrt(a * a + b * b);
			a = a/sx;
			b = b/sx;

			// factor out the skew
			var k = a * c + b * d;
			c -= a * k;
			d -= b * k;

			// factor out the Y scale
			var sy = Math.sqrt(c * c + d * d);
			c = c / sy;
			d = d / sy;
			k = k / sy;

			// account for negative scale
			if ((a * d - b * c) < 0.0) {
				a = -a;
				b = -b;
				//c = -c; // accomplishes nothing to negate it
				//d = -d; // accomplishes nothing to negate it
				sx = -sx;
				//sy = -sy //Scale Y shouldn't ever be negated
			}

			// calculate the rotation angle and skew angle
			var rad2deg = $.angle.radianToDegree;
			var r = rad2deg(Math.atan2(b, a));
			k = rad2deg(Math.atan(k));

			return {
				rotate: r + 'deg',
				skewX: k + 'deg',
				scaleX: sx,
				scaleY: sy,
				translateX: tx + 'px',
				translateY: ty + 'px'
			};
		}
	};

	/** Extend all of the matrix types with the same prototype */
	$.extend($m.M2x2.prototype, Matrix, {
		toM3x3: function() {
			var a = this.elements;
			return new $m.M3x3(
				a[0], a[1], 0,
				a[2], a[3], 0,
				0,    0,    1
			);	
		},

		/**
		 * Multiply a 2x2 matrix by a similar matrix or a vector
		 * @param M2x2 | V2 matrix
		 * @return M2x2 | V2
		 */
		x: function(matrix) {
			var isVector = typeof(matrix.rows) === 'undefined';

			// Ensure the right-sized matrix
			if (!isVector && matrix.rows == 3) {
				return this.toM3x3().x(matrix);
			}

			var a = this.elements,
				b = matrix.elements;

			if (isVector && b.length == 2) {
				// b is actually a vector
				return new $m.V2(
					a[0] * b[0] + a[1] * b[1],
					a[2] * b[0] + a[3] * b[1]
				);
			} else if (b.length == a.length) {
				// b is a 2x2 matrix
				return new $m.M2x2(
					a[0] * b[0] + a[1] * b[2],
					a[0] * b[1] + a[1] * b[3],

					a[2] * b[0] + a[3] * b[2],
					a[2] * b[1] + a[3] * b[3]
				);
			}
			return false; // fail
		},

		/**
		 * Generates an inverse of the current matrix
		 * @param void
		 * @return M2x2
		 * @link http://www.dr-lex.be/random/matrix_inv.html
		 */
		inverse: function() {
			var d = 1/this.determinant(),
				a = this.elements;
			return new $m.M2x2(
				d *  a[3], d * -a[1],
				d * -a[2], d *  a[0]
			);
		},

		/**
		 * Calculates the determinant of the current matrix
		 * @param void
		 * @return Number
		 * @link http://www.dr-lex.be/random/matrix_inv.html
		 */
		determinant: function() {
			var a = this.elements;
			return a[0] * a[3] - a[1] * a[2];
		}
	});

	$.extend($m.M3x3.prototype, Matrix, {
		/**
		 * Multiply a 3x3 matrix by a similar matrix or a vector
		 * @param M3x3 | V3 matrix
		 * @return M3x3 | V3
		 */
		x: function(matrix) {
			var isVector = typeof(matrix.rows) === 'undefined';

			// Ensure the right-sized matrix
			if (!isVector && matrix.rows < 3) {
				matrix = matrix.toM3x3();
			}

			var a = this.elements,
				b = matrix.elements;

			if (isVector && b.length == 3) {
				// b is actually a vector
				return new $m.V3(
					a[0] * b[0] + a[1] * b[1] + a[2] * b[2],
					a[3] * b[0] + a[4] * b[1] + a[5] * b[2],
					a[6] * b[0] + a[7] * b[1] + a[8] * b[2]
				);
			} else if (b.length == a.length) {
				// b is a 3x3 matrix
				return new $m.M3x3(
					a[0] * b[0] + a[1] * b[3] + a[2] * b[6],
					a[0] * b[1] + a[1] * b[4] + a[2] * b[7],
					a[0] * b[2] + a[1] * b[5] + a[2] * b[8],

					a[3] * b[0] + a[4] * b[3] + a[5] * b[6],
					a[3] * b[1] + a[4] * b[4] + a[5] * b[7],
					a[3] * b[2] + a[4] * b[5] + a[5] * b[8],

					a[6] * b[0] + a[7] * b[3] + a[8] * b[6],
					a[6] * b[1] + a[7] * b[4] + a[8] * b[7],
					a[6] * b[2] + a[7] * b[5] + a[8] * b[8]
				);
			}
			return false; // fail
		},

		/**
		 * Generates an inverse of the current matrix
		 * @param void
		 * @return M3x3
		 * @link http://www.dr-lex.be/random/matrix_inv.html
		 */
		inverse: function() {
			var d = 1/this.determinant(),
				a = this.elements;
			return new $m.M3x3(
				d * (  a[8] * a[4] - a[7] * a[5]),
				d * (-(a[8] * a[1] - a[7] * a[2])),
				d * (  a[5] * a[1] - a[4] * a[2]),

				d * (-(a[8] * a[3] - a[6] * a[5])),
				d * (  a[8] * a[0] - a[6] * a[2]),
				d * (-(a[5] * a[0] - a[3] * a[2])),

				d * (  a[7] * a[3] - a[6] * a[4]),
				d * (-(a[7] * a[0] - a[6] * a[1])),
				d * (  a[4] * a[0] - a[3] * a[1])
			);
		},

		/**
		 * Calculates the determinant of the current matrix
		 * @param void
		 * @return Number
		 * @link http://www.dr-lex.be/random/matrix_inv.html
		 */
		determinant: function() {
			var a = this.elements;
			return a[0] * (a[8] * a[4] - a[7] * a[5]) - a[3] * (a[8] * a[1] - a[7] * a[2]) + a[6] * (a[5] * a[1] - a[4] * a[2]);
		}
	});

	/** generic vector prototype */
	var Vector = {		
		/**
		 * Return a specific element from the vector
		 * @param Number i where 1 is the 0th value
		 * @return Number
		 */
		e: function(i) {
			return this.elements[i - 1];
		}
	};

	/** Extend all of the vector types with the same prototype */
	$.extend($m.V2.prototype, Vector);
	$.extend($m.V3.prototype, Vector);
})(jQuery, this, this.document);
///////////////////////////////////////////////////////
// Matrix Calculations
///////////////////////////////////////////////////////
(function($, window, document, undefined) {
	/**
	 * Matrix object for creating matrices relevant for 2d Transformations
	 * @var Object
	 */
	if (typeof($.matrix) == 'undefined') {
		$.extend({
			matrix: {}
		});
	}

	$.extend( $.matrix, {
		/**
		 * Class for calculating coordinates on a matrix
		 * @param Matrix matrix
		 * @param Number outerHeight
		 * @param Number outerWidth
		 * @constructor
		 */
		calc: function(matrix, outerHeight, outerWidth) {
			/**
			 * @var Matrix
			 */
			this.matrix = matrix;

			/**
			 * @var Number
			 */
			this.outerHeight = outerHeight;

			/**
			 * @var Number
			 */
			this.outerWidth = outerWidth;
		}
	});

	$.matrix.calc.prototype = {
		/**
		 * Calculate a coord on the new object
		 * @return Object
		 */
		coord: function(x, y, z) {
			//default z and w
			z = typeof(z) !== 'undefined' ? z : 0;

			var matrix = this.matrix,
				vector;

			switch (matrix.rows) {
				case 2:
					vector = matrix.x(new $.matrix.V2(x, y));
					break;
				case 3:
					vector = matrix.x(new $.matrix.V3(x, y, z));
					break;
			}

			return vector;
		},

		/**
		 * Calculate the corners of the new object
		 * @return Object
		 */
		corners: function(x, y) {
			// Try to save the corners if this is called a lot
			var save = !(typeof(x) !=='undefined' || typeof(y) !=='undefined'),
				c;
			if (!this.c || !save) {
				y = y || this.outerHeight;
				x = x || this.outerWidth;

				c = {
					tl: this.coord(0, 0),
					bl: this.coord(0, y),
					tr: this.coord(x, 0),
					br: this.coord(x, y)
				};
			} else {
				c = this.c;
			}

			if (save) {
				this.c = c;
			}
			return c;
		},

		/**
		 * Calculate the sides of the new object
		 * @return Object
		 */
		sides: function(corners) {
			// The corners of the box
			var c = corners || this.corners();

			return {
				top: Math.min(c.tl.e(2), c.tr.e(2), c.br.e(2), c.bl.e(2)),
				bottom: Math.max(c.tl.e(2), c.tr.e(2), c.br.e(2), c.bl.e(2)),
				left: Math.min(c.tl.e(1), c.tr.e(1), c.br.e(1), c.bl.e(1)),
				right: Math.max(c.tl.e(1), c.tr.e(1), c.br.e(1), c.bl.e(1))
			};
		},

		/**
		 * Calculate the offset of the new object
		 * @return Object
		 */
		offset: function(corners) {
			// The corners of the box
			var s = this.sides(corners);

			// return size
			return {
				height: Math.abs(s.bottom - s.top), 
				width: Math.abs(s.right - s.left)
			};
		},

		/**
		 * Calculate the area of the new object
		 * @return Number
		 * @link http://en.wikipedia.org/wiki/Quadrilateral#Area_of_a_convex_quadrilateral
		 */
		area: function(corners) {
			// The corners of the box
			var c = corners || this.corners();

			// calculate the two diagonal vectors
			var v1 = {
					x: c.tr.e(1) - c.tl.e(1) + c.br.e(1) - c.bl.e(1),
					y: c.tr.e(2) - c.tl.e(2) + c.br.e(2) - c.bl.e(2)
				},
				v2 = {
					x: c.bl.e(1) - c.tl.e(1) + c.br.e(1) - c.tr.e(1),
					y: c.bl.e(2) - c.tl.e(2) + c.br.e(2) - c.tr.e(2)
				};

			return 0.25 * Math.abs(v1.e(1) * v2.e(2) - v1.e(2) * v2.e(1));
		},

		/**
		 * Calculate the non-affinity of the new object
		 * @return Number
		 */
		nonAffinity: function() {
			// The corners of the box
			var sides = this.sides(),
				xDiff = sides.top - sides.bottom,
				yDiff = sides.left - sides.right;

			return parseFloat(parseFloat(Math.abs(
				(Math.pow(xDiff, 2) + Math.pow(yDiff, 2)) /
				(sides.top * sides.bottom + sides.left * sides.right)
			)).toFixed(8));
		},

		/**
		 * Calculate a proper top and left for IE
		 * @param Object toOrigin
		 * @param Object fromOrigin
		 * @return Object
		 */
		originOffset: function(toOrigin, fromOrigin) {
			// the origin to translate to
			toOrigin = toOrigin ? toOrigin : new $.matrix.V2(
				this.outerWidth * 0.5,
				this.outerHeight * 0.5
			);

			// the origin to translate from (IE has a fixed origin of 0, 0)
			fromOrigin = fromOrigin ? fromOrigin : new $.matrix.V2(
				0,
				0
			);

			// transform the origins
			var toCenter = this.coord(toOrigin.e(1), toOrigin.e(2));
			var fromCenter = this.coord(fromOrigin.e(1), fromOrigin.e(2));

			// return the offset
			return {
				top: (fromCenter.e(2) - fromOrigin.e(2)) - (toCenter.e(2) - toOrigin.e(2)),
				left: (fromCenter.e(1) - fromOrigin.e(1)) - (toCenter.e(1) - toOrigin.e(1))
			};
		}
	};
})(jQuery, this, this.document);
///////////////////////////////////////////////////////
// 2d Matrix Functions
///////////////////////////////////////////////////////
(function($, window, document, undefined) {
	/**
	 * Matrix object for creating matrices relevant for 2d Transformations
	 * @var Object
	 */
	if (typeof($.matrix) == 'undefined') {
		$.extend({
			matrix: {}
		});
	}
	var $m = $.matrix,
		$m2x2 = $m.M2x2,
		$m3x3 = $m.M3x3;

	$.extend( $m, {
		/**
		 * Identity matrix
		 * @param Number size
		 * @return Matrix
		 */
		identity: function(size) {
			size = size || 2;
			var length = size * size,
				elements = new Array(length),
				mod = size + 1;
			for (var i = 0; i < length; i++) {
				elements[i] = (i % mod) === 0 ? 1 : 0;
			}
			return new $m['M'+size+'x'+size](elements);
		},

		/**
		 * Matrix
		 * @return Matrix
		 */
		matrix: function() {
			var args = Array.prototype.slice.call(arguments);
			// arguments are in column-major order
			switch (arguments.length) {
				case 4:
					return new $m2x2(
						args[0], args[2],
						args[1], args[3]
					);
				case 6:
					return new $m3x3(
						args[0], args[2], args[4],
						args[1], args[3], args[5],
						0,       0,       1
					);
			}
		},

		/**
		 * Reflect (same as rotate(180))
		 * @return Matrix
		 */
		reflect: function() {
			return new $m2x2(
				-1,  0,
				 0, -1
			);
		},

		/**
		 * Reflect across the x-axis (mirrored upside down)
		 * @return Matrix
		 */
		reflectX: function() {	
			return new $m2x2(
				1,  0,
				0, -1
			);
		},

		/**
		 * Reflect by swapping x an y (same as reflectX + rotate(-90))
		 * @return Matrix
		 */
		reflectXY: function() {
			return new $m2x2(
				0, 1,
				1, 0
			);
		},

		/**
		 * Reflect across the y-axis (mirrored)
		 * @return Matrix
		 */
		reflectY: function() {
			return new $m2x2(
				-1, 0,
				 0, 1
			);
		},

		/**
		 * Rotates around the origin
		 * @param Number deg
		 * @return Matrix
		 * @link http://www.w3.org/TR/SVG/coords.html#RotationDefined
		 */
		rotate: function(deg) {
			//TODO: detect units
			var rad = $.angle.degreeToRadian(deg),
				costheta = Math.cos(rad),
				sintheta = Math.sin(rad);

			var a = costheta,
				b = sintheta,
				c = -sintheta,
				d = costheta;

			return new $m2x2(
				a, c,
				b, d
			);
		},

		/**
		 * Scale
		 * @param Number sx
		 * @param Number sy
		 * @return Matrix
		 * @link http://www.w3.org/TR/SVG/coords.html#ScalingDefined
		 */
		scale: function (sx, sy) {
			sx = sx || sx === 0 ? sx : 1;
			sy = sy || sy === 0 ? sy : sx;

			return new $m2x2(
				sx, 0,
				0, sy
			);
		},

		/**
		 * Scale on the X-axis
		 * @param Number sx
		 * @return Matrix
		 */
		scaleX: function (sx) {
			return $m.scale(sx, 1);
		},

		/**
		 * Scale on the Y-axis
		 * @param Number sy
		 * @return Matrix
		 */
		scaleY: function (sy) {
			return $m.scale(1, sy);
		},

		/**
		 * Skews on the X-axis and Y-axis
		 * @param Number degX
		 * @param Number degY
		 * @return Matrix
		 */
		skew: function (degX, degY) {
			degX = degX || 0;
			degY = degY || 0;

			//TODO: detect units
			var radX = $.angle.degreeToRadian(degX),
				radY = $.angle.degreeToRadian(degY),
				x = Math.tan(radX),
				y = Math.tan(radY);

			return new $m2x2(
				1, x,
				y, 1
			);
		},

		/**
		 * Skews on the X-axis
		 * @param Number degX
		 * @return Matrix
		 * @link http://www.w3.org/TR/SVG/coords.html#SkewXDefined
		 */
		skewX: function (degX) {
			return $m.skew(degX);
		},

		/**
		 * Skews on the Y-axis
		 * @param Number degY
		 * @return Matrix
		 * @link http://www.w3.org/TR/SVG/coords.html#SkewYDefined
		 */
		skewY: function (degY) {
			return $m.skew(0, degY);
		},

		/**
		 * Translate
		 * @param Number tx
		 * @param Number ty
		 * @return Matrix
		 * @link http://www.w3.org/TR/SVG/coords.html#TranslationDefined
		 */
		translate: function (tx, ty) {
			tx = tx || 0;
			ty = ty || 0;

			return new $m3x3(
				1, 0, tx,
				0, 1, ty,
				0, 0, 1
			);
		},

		/**
		 * Translate on the X-axis
		 * @param Number tx
		 * @return Matrix
		 * @link http://www.w3.org/TR/SVG/coords.html#TranslationDefined
		 */
		translateX: function (tx) {
			return $m.translate(tx);
		},

		/**
		 * Translate on the Y-axis
		 * @param Number ty
		 * @return Matrix
		 * @link http://www.w3.org/TR/SVG/coords.html#TranslationDefined
		 */
		translateY: function (ty) {
			return $m.translate(0, ty);
		}
	});
})(jQuery, this, this.document);




	(function($) {

		$.accordionGallery = function (wrapper, settings) {


		var componentInited = false;	

		var sliderWrapper = $(wrapper);

		var is_chrome = /chrome/.test( navigator.userAgent.toLowerCase());
		// console.log(is_chrome);
		 var is_safari = ($.browser.safari && /chrome/.test(navigator.userAgent.toLowerCase()) ) ? false : true;
		// console.log(is_safari);
		 //safari - false, true
		 //chrome - true, false

		 var isIEbelow9 = false;
		if($.browser.msie && parseInt($.browser.version, 10) < 9){
			isIEbelow9=true;
		}

		var slideshowOn=settings.slideshowOn;
		var slideshowTimeout = settings.slideshowDelay;
		var slideshowTimeoutID; 
		var counter=-1;

		var videoDisablesAllNavigation=settings.videoDisablesAllNavigation;
		var navigationActive = true;
		var useKeyboardNavigation=settings.useKeyboardNavigation;
		var useControls=settings.useControls;

		var controls_play_url='data/icons/controls_play.gif';
		var controls_pause_url='data/icons/controls_pause.gif';
		var playBtnUrl='data/icons/play2.png';

		if(useControls){
			var controls = sliderWrapper.find('.controls');
			var controls_prev = sliderWrapper.find('.controls_prev');
			var controls_toggle = sliderWrapper.find('.controls_toggle');
			var controls_next = sliderWrapper.find('.controls_next');

			controls_prev.css('cursor', 'pointer');
			controls_toggle.css('cursor', 'pointer');
			controls_next.css('cursor', 'pointer');

			controls_prev.bind('click', clickControls);
			controls_toggle.bind('click', clickControls);
			controls_next.bind('click', clickControls);

			var controlsToggleSrc=controls_toggle.find('img');
			if(slideshowOn) controlsToggleSrc.attr('src', controls_pause_url);
		}else{
			sliderWrapper.find('.controls').remove();
		}

		var _customContentArr=[];//fade all custom content on intro, not before

		var openOnClickAllSlidesButtonMode=settings.openOnClickAllSlidesButtonMode;
		var useGlobalDelay = settings.useGlobalDelay;

		var orientation = settings.orientation;

		var sliderHolder = sliderWrapper.find('.sliderHolder');
		var sliderImages = sliderWrapper.find('.sliderImages');
		var sliderCointainer = sliderWrapper.find('.sliderCointainer');

		var openOnRollover = settings.openOnRollover;

		var captionStartTimeoutID; 

		var windowResizeInterval = 500;

		var unSelectableCaptions=settings.unSelectableCaptions;//prevent captions mouse select

		var captionOpenDelay=120;
		var captionToggleSpeed=500;
		var captionMoveValue = 100;

		var dataArr = $(sliderImages.find('div[data-title=slide]'));
		var playlistLength = dataArr.length;
		var openSlideNum=settings.openSlideNum;
		if(openSlideNum > playlistLength-1) playlistLength = playlistLength-1;
		var visibleItems = settings.visibleItems;
		var totalItems = playlistLength;
		if(visibleItems > totalItems) visibleItems = totalItems;
		var allSlidesVisible = false;
		if(visibleItems == totalItems) allSlidesVisible =true;

		var useScroll = settings.useScroll;
		var keepSelection = settings.keepSelection;
		if(!keepSelection && visibleItems == totalItems) useScroll = false;

		var randomPlay = settings.randomPlay;
		if(randomPlay){
			//shuffle array to make it random, dont use random class
			shuffleArray(dataArr);
		}

		//autoplay for ithing
		var videoAutoplay;
		var agent = navigator.userAgent;
		if(agent.search("iPhone") == -1 && agent.search("iPad") == -1 && agent.search("iPod") == -1) {
			 videoAutoplay =settings.videoAutoplay;
		}else {
			videoAutoplay = false;
		}

		var slideArr = [];
		var titleArr =[];
		var imgArr =[];

		var imageCount=0;
		var divClosingBorder;

		var transitionTime = settings.transitionTime;
		var transitionEase = settings.transitionEase;

		var hideTitleOnOpen=settings.hideTitleOnOpen;

		var closeVideoBtn;
		var closeVideoBtnOffOpacity = 0.6;
		var closeText;

		var componentWidth =settings.componentWidth;
		var componentHeight =settings.componentHeight;

		sliderWrapper.css('width', componentWidth + 'px');
		sliderWrapper.css('height', componentHeight + 'px');

		sliderCointainer.css('width', componentWidth + 'px');
		sliderCointainer.css('height', componentHeight + 'px');

		//sliderHolder.css('width', componentWidth + 'px');
		sliderHolder.css('height', componentHeight + 'px');

		//create holders for video iframes
		var ytHolderDiv = $("<div></div>");
		ytHolderDiv.css('position', 'relative');
		ytHolderDiv.css('width', componentWidth + 'px');
		ytHolderDiv.css('height', componentHeight + 'px');
		ytHolderDiv.css('left', 0);
		ytHolderDiv.css('top', 0);
		ytHolderDiv.css('opacity', 0);
		ytHolderDiv.css('zIndex', -10);
		sliderWrapper.prepend(ytHolderDiv);

		var vimeoHolderDiv = $("<div></div>");
		vimeoHolderDiv.css('position', 'absolute');
		vimeoHolderDiv.css('width', componentWidth + 'px');
		vimeoHolderDiv.css('height', componentHeight + 'px');
		var pl=parseInt(sliderCointainer.css('left'),10);//correct for vimeo container
		var pt=parseInt(sliderCointainer.css('top'),10);
		vimeoHolderDiv.css('left', pl+'px');
		vimeoHolderDiv.css('top', pt+'px');
		vimeoHolderDiv.css('display', 'none');
		vimeoHolderDiv.css('zIndex', -11);
		sliderWrapper.prepend(vimeoHolderDiv);

		var ytInited =  false;
		var vimeoInited =  false;
		var vimeoVideoIframe;
		var youtubeVideoIframe;
		var ytStarted=false;
		var videoIsOn=false;
		var isVimeo =false;//vimeo or yt
		var includeVideoInSlideshow = settings.includeVideoInSlideshow;
		var ytStartIntervalID; 
		var ytStartInterval = 100; 
		var openYoutubeOnBuffering = settings.openYoutubeOnBuffering;

		var componentHit=false;

		var useBorder=settings.useBorder;
		if(useBorder){
			var borderSize = settings.borderSize;
			var borderColor = settings.borderColor;
			var borderAlpha = settings.borderAlpha;
		}

		//scroll vars
		var _scroll = sliderWrapper.find('.scroll');
		var dragger = sliderWrapper.find('.scrollBar');
		var track = sliderWrapper.find('.scrollTrack');
		var scrollOrientation=settings.scrollOrientation;
		var scrollTrackSize = scrollOrientation == 'horizontal' ? track.width() : track.height();
		var draggerSize = scrollOrientation == 'horizontal' ? dragger.width() : dragger.height(); 
		if(!useScroll){
			_scroll.remove();
		}else{

			dragger.css('cursor', 'pointer');
			track.css('cursor', 'pointer');

			var draggerPositionClicked = 0;
			var draggerInitalPosition = 0;
			var draggingOn=false;
			var draggerPosition=0;
			var scrollContentSize;
			var newContentPosition=0;	
			var contentPosition=0;
			var scrollerEase = 1;
			var draggerOverColor = settings.scrollDraggerOverColor;
			var draggerColor = dragger.css('background');
			var useMouseWheel=false;
			var scrollContentIntervalID = null;
			var scrollContentInterval = 50;
			var draggerMouseDownIntervalID = null;
			var draggerMouseDownInterval = 300;//IMPORTANT OPTIMIZATION!  the slower the interval (aka the higher the value), the less the openSlide function will get called when dragging scroll drager. Also, value shouldnt be too high, because it could still be jerky because of too rare function calls. This was made to optimize dragging on mouse dragger down which was being called to often.
			var draggerMouseClickValue = 0;
			var scrollHit = false;//mouse over track/dragger
			var contentFactorMoveValue = 0;

		}












		loadImages();

		function loadImages(){

			//get image count 
			var i = 0;
			var slide;
			var img;
			var imageUrl;
			var imageLoadCounter=0;

			for(i; i < playlistLength; i++){
				slide = $(dataArr[i]);

				if(slide.attr('data-content') != undefined){
					imageCount++;

					img =$(new Image());
					img.attr('id', i);
					img.css('position', 'absolute');
					img.css('display', 'block');

					imgArr.push(img);

					imageUrl = slide.attr('data-path')+"?rand=" + (Math.random() * 99999999);
					//console.log(imageUrl);

					img.load(function() {

						//console.log(this);
						//console.log(this.width);
						var id = $(this).attr('id');

						imageLoadCounter++;
						if(imageLoadCounter == imageCount) {
							//ALL IMAGES LOADED

							preventSelect(imgArr);//prevent image selecting

							initAll();
						}

					}).attr('src', imageUrl);

					img.error(function(e) {
						//console.log('image load error: ' + e);
					});

				}else{
					imgArr.push('');//no image in slide
					//console.log(i);
				}
			}
		}



		function initAll(){

			var i = 0;
			var img;
			var imgCustomSize;
			var div;


			var fontMeasure = sliderWrapper.find('.fontMeasure');

			// title
			var k;
			var title;
			var titleLen;
			var titleHtml;
			var titleDiv;
			var titleWidth;
			var titleHeight;
			var titleBgColor; 
			var titleTextColor;
			var titleX;
			var titleY;
			var titleClassData;
			var titleAlignment;
			var titleRotation;
			var lefttitlePadding;
			var righttitlePadding;
			var toptitlePadding;
			var bottomtitlePadding; 
			var finaltitleWidth;
			var finaltitleHeight;


			//captions
			var j;
			var captionLen;
			var captionArr;
			var caption;
			var captionInner;
			var captionHtml;
			var captionDiv;
			var captionMaskerDiv;
			var captionWidth;
			var captionHeight;
			var captionBgColor; 
			var captionTextColor;
			var captionX;
			var captionY;
			var captionClassData;
			var leftCaptionPadding;
			var rightCaptionPadding;
			var topCaptionPadding;
			var bottomCaptionPadding; 
			var finalCaptionWidth;
			var finalCaptionHeight;

			//custom content
			var customContent;
			var customContentArr;

			var slide;
			var z=0;
			var zlen;

			var videoIFrame;
			var videoIFrameDiv;
			var videoIFrameSrc;
			var videoIFramePath;


			i=0;
			for(i; i <playlistLength; i++){

				slide = $(dataArr[i]);
				img = $(imgArr[i]);

				 if(slide.attr('data-content') != undefined){
					imgCustomSize = orientation == 'horizontal' ? parseInt(img[0].width, 10) : parseInt(img[0].height, 10);
				}else{
					if(slide.attr('data-width') != undefined && slide.attr('data-height') != undefined){
						imgCustomSize = orientation == 'horizontal' ? parseInt(slide.attr('data-width'), 10) : parseInt(slide.attr('data-height'), 10);
					}else{
						alert('slides with no images need to have data-width (orientation horizontal) and data-height (orientation vertical) attributes, check slide number: ' + parseInt(i+1,10));
					}
				}

				div = $("<div></div>");
				//div.css('opacity', 0);//FIX FOR IE7/8, ADD AFTER BECAUSE OF DROP SHADOW
				div.attr('id', i);
				div.attr('class', 'slideDiv');
				div.customSize = imgCustomSize;
				//console.log(i, ' , ', imgCustomSize);

				if(orientation == 'horizontal'){
					div.css('width', imgCustomSize + 'px');
					div.css('height', componentHeight + 'px');
				}else{
					div.css('width', componentWidth + 'px');
					div.css('height', imgCustomSize + 'px');
				}

				if(slide.attr('data-content') != undefined) div.append(img);
				div[0].opened=false;


				if(useBorder){
					div.css("border", "solid");
					div.css("border-width", borderSize+"px");
					div.css("border-color", borderColor);

					//put fake closing vertical border on last div
					if(i == playlistLength - 1){
						divClosingBorder = $("<div></div>");
						divClosingBorder.css('position', 'absolute');
						divClosingBorder.css('background', borderColor);

						if(orientation == 'horizontal'){
							//resize elements for new size
							sliderCointainer.css('height', componentHeight + (2 * borderSize) + 'px');
							sliderCointainer.css('width', componentWidth + borderSize + 'px');

							ytHolderDiv.css('width', componentWidth + borderSize + 'px');
							ytHolderDiv.css('height', componentHeight + (2 * borderSize) + 'px');
							vimeoHolderDiv.css('width', componentWidth + borderSize + 'px');
							vimeoHolderDiv.css('height', componentHeight + (2 * borderSize) + 'px');

							divClosingBorder.css('width', borderSize + 'px');
							divClosingBorder.css('height', componentHeight + (2 * borderSize) + 'px');
							divClosingBorder.css('top', 0);
							divClosingBorder.css('left', componentWidth + 'px');
						}else{
							sliderCointainer.css('width', componentWidth + (2 * borderSize) + 'px');
							sliderCointainer.css('height', componentHeight + borderSize + 'px');	

							ytHolderDiv.css('width', componentWidth + (2 * borderSize) + 'px');
							ytHolderDiv.css('height', componentHeight + borderSize + 'px');
							vimeoHolderDiv.css('width', componentWidth + (2 * borderSize) + 'px');
							vimeoHolderDiv.css('height', componentHeight + borderSize + 'px');

							divClosingBorder.css('width', componentWidth + (2 * borderSize) + 'px');
							divClosingBorder.css('height', borderSize + 'px');
							divClosingBorder.css('left', 0);
							divClosingBorder.css('top', componentHeight + 'px');
						}	

						sliderCointainer.append(divClosingBorder);
					}
				}



				if(openOnRollover){
					div.bind('mouseenter', overCategoryItem);
					div.bind('mouseleave', outCategoryItem);
				}else{
					div.bind('click', openSlideOnClick);
					if(openOnClickAllSlidesButtonMode) div.css('cursor', 'pointer');//in click mode, give all slides button mode to indicate open on click
				}


				slideArr.push(div);	
				sliderHolder.append(div);



				if(slide.attr('data-content') != undefined){

					if(slide.attr('data-link') != undefined){

						if(slide.attr('data-content') == 'image'){

							if(slide.attr('data-link') != undefined){	
								div.link=slide.attr('data-link');
								div.action = 'link';
								if(slide.attr('data-target') != undefined) div.get(0).linkTarget=slide.attr('data-target');
								div.css('cursor', 'pointer');
							}
						}
						else if(slide.attr('data-content') == 'youtube'){
							div.link = slide.attr('data-link');
							div.action = 'youtube';
							div.css('cursor', 'pointer');
							createPlayBtn(div);
						}
						else if(slide.attr('data-content') == 'vimeo'){
							div.link = slide.attr('data-link');
							div.action = 'vimeo';
							div.css('cursor', 'pointer');
							createPlayBtn(div);
						}

					}

					//find custom content within data content
					customContentArr = slide.find('div[data-content=custom]');
					//console.log('customContentArr = ', customContentArr.length, customContentArr);
					z=0;
					zlen = customContentArr.length;
					for(z; z < zlen; z++){
						customContent = $(customContentArr[z]);
						customContent.css('display', 'none');
						div.append(customContent);
					}
					if(zlen>0)_customContentArr.push(customContentArr);

				}else if(slide.attr('data-content') == undefined){//find custom content outside data content

					customContentArr = slide.find('div[data-content=custom]');
					//console.log('customContentArr = ', customContentArr.length, customContentArr);
					z=0;
					zlen = customContentArr.length;
					for(z; z < zlen; z++){
						customContent = $(customContentArr[z]);
						customContent.css('display', 'none');
						div.append(customContent);
					}
					if(zlen>0)_customContentArr.push(customContentArr);

				}









				//title
				k=0;
				title = slide.find('p[data-title=title]');
				//console.log(titleLen);
				titleLen= title.size();
				if(titleLen > 1) titleLen = 1;//only 1 title allowed
				//console.log(i, titleLen);

				if(titleLen == 0) titleArr.push('');

				for(k; k < titleLen;k++){

					titleHtml = title.html();
					titleBgColor = title.css('backgroundColor'); 
					titleTextColor = title.css('color');
					//console.log(titleBgColor, titleTextColor);

					titleClassData = title.attr('class').split(',');
					titleRotation = parseInt(titleClassData[0], 10);
					titleAlignment = titleClassData[1].toLowerCase();
					titleX = parseInt(titleClassData[2], 10);
					titleY = parseInt(titleClassData[3], 10);

					titleDiv = $("<div />").html(titleHtml).addClass('title').appendTo(fontMeasure);

					titleWidth = titleDiv.width() + 1;
					titleHeight = titleDiv.height() + 1;

					lefttitlePadding =parseInt($(titleDiv).css('paddingLeft'),10);
					righttitlePadding =parseInt($(titleDiv).css('paddingRight'),10);
					toptitlePadding =parseInt($(titleDiv).css('paddingTop'),10);
					bottomtitlePadding =parseInt($(titleDiv).css('paddingBottom'),10); 
					//console.log(lefttitlePadding,righttitlePadding, toptitlePadding , bottomtitlePadding);

					finaltitleWidth =  titleWidth + lefttitlePadding + righttitlePadding;
					finaltitleHeight = titleHeight + toptitlePadding + bottomtitlePadding;
					//console.log(titleWidth, titleHeight, finaltitleWidth, finaltitleHeight);

					titleDiv.css('width', titleWidth + 'px');
					titleDiv.css('height', titleHeight + 'px' );
					if(titleBgColor!=undefined)titleDiv.css('background', titleBgColor);
					if(titleTextColor!=undefined)titleDiv.css('color', titleTextColor);	

					if(orientation == 'horizontal'){
						if(titleRotation == '-90'){
							console.log("in...");
							titleDiv.transform({rotate: -90+'deg'});
						}else{//90
							titleDiv.transform({rotate: 90+'deg'});
						}

						if(titleAlignment=='tl'){
							//align from top left
							if(!isIEbelow9){
								titleDiv.css('left', - finaltitleWidth / 2 + finaltitleHeight / 2 + titleX + 'px');
								titleDiv.css('top', finaltitleWidth / 2 -  finaltitleHeight / 2 + titleY + 'px');
							}else{
								titleDiv.css('left', titleX + 'px');
								titleDiv.css('top', titleY + 'px');
							}
						}else{//bl
							//align from bottom left
							if(!isIEbelow9){
								titleDiv.css('left', - finaltitleWidth / 2 + finaltitleHeight / 2 + titleX + 'px');
								titleDiv.css('top', componentHeight - finaltitleWidth / 2 - finaltitleHeight / 2 - titleY + 'px');
							}else{
								titleDiv.css('left', titleX + 'px');
								titleDiv.css('top', componentHeight - finaltitleWidth - titleY + 'px');
							}
						}

					}else{
						titleDiv.css('left', titleX + 'px');
						titleDiv.css('top', titleY + 'px');	
					}

					titleDiv.transform({rotate: -90+'deg'});
					
					titleDiv.appendTo(div);
					titleArr.push(titleDiv);

				}

				//caption

				j=0;
				caption=slide.find('p[data-title=caption]');
				captionLen = caption.size();
				captionArr = [];

				for(j; j < captionLen;j++){

					captionInner=$(caption[j]);

					captionHtml = captionInner.html();
					captionBgColor = captionInner.css('backgroundColor'); 
					captionTextColor = captionInner.css('color');
					captionClassData = captionInner.attr('class').split(',');
					captionX = parseInt(captionClassData[0], 10);
					captionY = parseInt(captionClassData[1], 10);

					captionDiv = $("<div />").html(captionHtml).addClass('caption').appendTo(fontMeasure);

					captionWidth = captionDiv.width() + 1;
					captionHeight = captionDiv.height() + 1;

					captionDiv.css('position', 'absolute');
					captionDiv.css('width', captionWidth + 'px');
					captionDiv.css('height', captionHeight + 'px' );
					if(captionTextColor!=undefined)captionDiv.css('color', captionTextColor);	


					//masker
					leftCaptionPadding =parseInt($(captionDiv).css('paddingLeft'),10);
					rightCaptionPadding =parseInt($(captionDiv).css('paddingRight'),10);
					topCaptionPadding =parseInt($(captionDiv).css('paddingTop'),10);
					bottomCaptionPadding =parseInt($(captionDiv).css('paddingBottom'),10); 

					finalCaptionWidth =  captionWidth + leftCaptionPadding + rightCaptionPadding;
					finalCaptionHeight = captionHeight + topCaptionPadding + bottomCaptionPadding;

					captionMaskerDiv	 = $("<div />").addClass("captionHolder");
					captionMaskerDiv.finalWidth = finalCaptionWidth;//remember final width

					captionMaskerDiv.css('width', 0);//
					captionMaskerDiv.css('height', finalCaptionHeight + 'px' );

					captionMaskerDiv.origLeft=captionX;
					captionMaskerDiv.css('left', captionX+captionMoveValue + 'px');
					captionMaskerDiv.css('top', captionY + 'px');
					if(captionBgColor!=undefined)captionMaskerDiv.css('background', captionBgColor);


					captionMaskerDiv.appendTo(div);
					captionDiv.appendTo(captionMaskerDiv);

					captionArr.push(captionMaskerDiv);

				}

				if(captionLen > 0){
					div.captions=captionArr;//remember captions
					if(unSelectableCaptions) preventSelect(captionArr);
				}


			}

			//clean
			fontMeasure.remove();
			if(unSelectableCaptions) preventSelect(titleArr);

			setupDone();

		}

		function correctCustomContent() {
			//console.log('correctCustomContent')
			//http://stackoverflow.com/questions/4528490/google-map-v3-off-center-in-hidden-div
			//google.maps.event.trigger(gmap, 'resize');

			//ADD YOUR OWN CUSTOM CODE HERE IF NEEDED

		}

		function setupDone() {					

			correctCustomContent();

			var size = orientation == 'horizontal' ? componentWidth : componentHeight;
			scrollContentSize = parseInt((totalItems * (size / visibleItems)), 10);///unopened size
			//console.log('scrollContentSize = ', scrollContentSize);



			//SCROLL
			if(useScroll){

				dragger.bind('mouseover', function(){
					if(!navigationActive) return;

					scrollHit = true;
					dragger.css("background-color", draggerOverColor);

					return false;
				});

				dragger.bind('mouseout', function(){ 
					if(!navigationActive) return;

					scrollHit = false;
					if(!draggingOn && counter!=-1) positionDraggerOnSegment(counter);
					if(!draggingOn) dragger.css("background-color", draggerColor); 

					return false;
				});

				track.bind('mouseover', function(){
					if(!navigationActive) return;
					scrollHit = true;
					return false;
				});

				track.bind('mouseout', function(){ 
					if(!navigationActive) return;
					scrollHit = false;
					return false;
				});

				dragger.bind('mousedown touchstart MozTouchDown', function(e) {

					if (!e) var e = window.event;
					if(e.cancelBubble) e.cancelBubble = true;
					else if (e.stopPropagation) e.stopPropagation();

					if(!navigationActive) return;
					//console.log('dragger mousedown');

					draggingOn=true;

					draggerPositionClicked = scrollOrientation == 'horizontal' ? e.pageX : e.pageY; 
					//console.log('draggerPositionClicked = ', draggerPositionClicked);
					draggerInitalPosition = scrollOrientation == 'horizontal' ? parseInt( dragger.css("left") , 10) : parseInt( dragger.css("top") , 10); 
					//console.log('draggerInitalPosition = ', draggerInitalPosition);

					$(document).bind('mousemove', scrollerDown);//just for changing dragger position

					if(draggerMouseDownIntervalID) clearInterval(draggerMouseDownIntervalID);
					draggerMouseDownIntervalID = setInterval(scrollerDown2, draggerMouseDownInterval);//just for changing slides

					$(document).bind('mouseup touchend MozTouchUp', documentUp);

					if(!allSlidesVisible && counter > -1){//update content only if visible items < total items
						if(scrollContentIntervalID) clearInterval(scrollContentIntervalID);
						scrollContentIntervalID = setInterval(updateContentViaScroll, scrollContentInterval);
					}

					return false;
				});

				track.bind('mousedown touchstart MozTouchDown', function(e) {

					if (!e) var e = window.event;
					if(e.cancelBubble) e.cancelBubble = true;
					else if (e.stopPropagation) e.stopPropagation();

					if(!navigationActive) return;

					var offset = track.offset();
					if(scrollOrientation == 'horizontal'){
						draggerPosition = e.pageX - offset.left;
					}else{
						draggerPosition = e.pageY - offset.top;
					}	

					if(draggerPosition<0) draggerPosition=0;
					//else if(draggerPosition>(scrollTrackSize-draggerSize)) draggerPosition=(scrollTrackSize-draggerSize);

					updateSlidesViaTrack();
					if(!allSlidesVisible  && counter > -1) updateContentViaScroll();//update content only if visible items < total items

					return false;
				});

				track.bind('mouseup touchend MozTouchUp', function(e) {

					if (!e) var e = window.event;
					if(e.cancelBubble) e.cancelBubble = true;
					else if (e.stopPropagation) e.stopPropagation();

					if(!navigationActive) return;
					//console.log('........track mouseup');

					$(document).unbind('mouseup touchend MozTouchUp', documentUp);
					$(document).unbind('mousemove', scrollerDown);
					if(draggerMouseDownIntervalID) clearInterval(draggerMouseDownIntervalID);
					if(scrollContentIntervalID) clearInterval(scrollContentIntervalID);

					dragger.css("background-color", draggerColor);
					draggingOn=false;
					if(counter!=-1) positionDraggerOnSegment(counter);

					return false;
				});

			}






			if(useKeyboardNavigation){
				$(document).keyup(function (e) {

					if (!e) var e = window.event;
					if(e.cancelBubble) e.cancelBubble = true;
					else if (e.stopPropagation) e.stopPropagation();

					if(!navigationActive) return;
					  //console.log(event.keyCode);
					  if (e.keyCode == 37) {
						  previousSlide(true);
					  } 
					  else if (e.keyCode == 39) {
						  nextSlide(true);
					  }
				});

			}



			componentInited=true;

			distributeSpace();

			if(!openOnRollover){
				sliderWrapper.bind('mouseenter', overSlider);
				sliderWrapper.bind('mouseleave', outSlider);	
			}

			if(openSlideNum != -1) counter = openSlideNum;

			if(slideshowOn){
				if(counter==-1) counter = 0;//if left from openSlideNum and slideshow on, set it to zero 
				openSlide(counter, true);
				positionDraggerOnSegment(counter);
				if(!openOnRollover && slideArr[counter].action != undefined) checkSlideAction(counter);
			}else{
				if(counter!=-1) openSlide(counter, true);
			}

			//hide loader
			var componentLoader = $('#componentLoader');
			if(componentLoader){
				componentLoader.stop().animate({'opacity': 0},  {duration: 500, easing: "easeOutSine", complete: function(){
					componentLoader.remove();
					componentLoader = null;	

					//show component
					showComponent();
				}});
			}else{
				//show component
				showComponent();
			}

		}


		function showComponent(){
			sliderWrapper.stop().animate({'opacity': 1},  {duration: 500, easing: "easeOutSine"});

			if(useControls) controls.animate({opacity: 1 }, {duration: 500, easing: "easeOutSine"});
			if(useScroll){
				_scroll.animate({opacity: 1 }, {duration: 500, easing: "easeOutSine"});
			}

			//show custom content
			var i=0;
			var j;
			var cc;
			var len=_customContentArr.length;
			var len2;
			for(i; i < len;i++){
				j=0;
				len2=_customContentArr[i].length;
				for(j; j < len2;j++){
					cc=$(_customContentArr[i][j]);
					if(cc) cc.css('display', 'block');
				}
			}
			correctCustomContent();
		}

		//SCROLL
		function documentUp(e){

			if (!e) var e = window.event;
			if(e.cancelBubble) e.cancelBubble = true;
			else if (e.stopPropagation) e.stopPropagation();

			 if(!navigationActive) return;
			// console.log('document mouseup');

			 $(document).unbind('mouseup touchend MozTouchUp', documentUp);
			 $(document).unbind('mousemove', scrollerDown);
			 if(draggerMouseDownIntervalID) clearInterval(draggerMouseDownIntervalID);
			 if(scrollContentIntervalID) clearInterval(scrollContentIntervalID);

			 dragger.css("background-color", draggerColor);
			 draggingOn=false;
			 if(counter!=-1) positionDraggerOnSegment(counter);

			 return false;
		};	

		function scrollerDown2(){

			if(!navigationActive) return;
			//console.log('scrollerDown2');
			updateSlidesViaDrag();
		}

		function scrollerDown(e){

			if (!e) var e = window.event;
			if(e.cancelBubble) e.cancelBubble = true;
			else if (e.stopPropagation) e.stopPropagation();

			if(!navigationActive) return;
			//console.log('scrollerDown...........');

			draggerMouseClickValue = scrollOrientation == 'horizontal' ? e.pageX : e.pageY; 
			var dif = draggerMouseClickValue - draggerPositionClicked;
			draggerPosition = (draggerInitalPosition+dif);

			if(draggerPosition<0) draggerPosition=0;
			else if(draggerPosition>(scrollTrackSize-draggerSize)) draggerPosition=(scrollTrackSize-draggerSize);

			if(scrollOrientation == 'horizontal'){
				dragger.css("left", draggerPosition+"px");
			}else{
				dragger.css("top", draggerPosition+"px");
			}

		}

		function updateSlidesViaTrack(){
			if(!navigationActive) return;

			var segment = Math.floor((draggerPosition * totalItems)/ (scrollTrackSize));
			//console.log('segment = ', segment);

			if(!keepSelection && counter==-1){

				var size = orientation == 'horizontal' ? componentWidth : componentHeight;
				contentFactorMoveValue = size / visibleItems;

				var perc =  Math.floor((draggerPosition/(scrollTrackSize-draggerSize)*(totalItems - visibleItems)));
				//console.log(- contentFactorMoveValue * perc);

				var prop = {};
				var animProp = orientation == 'horizontal' ? 'left' : 'top';

				prop[animProp] = - contentFactorMoveValue * perc + 'px';
				sliderHolder.stop().animate(prop,  {duration: 350, easing: 'easeOutSine'});

				//
				positionDraggerOnSegment(segment);

				return;	
			};

			var item = $(slideArr[segment]);
			//console.log(item[0].opened);
			if(item[0].opened) return;//prevent openSlide call while mouse down on dragger and no segment change


			if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);
			if(videoIsOn){
				if(isVimeo){
					forceVimeoEnd();
				}else{
					forceYoutubeEnd();
				}
			}

			hidePreviousSlideData(counter);
			counter = segment;
			openSlide(counter);
			if(!openOnRollover && slideArr[counter].action != undefined) checkSlideAction(counter);
		}

		/*
		scroll size may be different than number of segments/tracks length so we need separate calculation for scroll drag and slide sort
		*/
		function updateSlidesViaDrag(){
			if(!navigationActive) return;
			//console.log('updateSlidesViaDrag');

			//scroll working while no item opened
			if(!keepSelection && counter==-1){

				var size = orientation == 'horizontal' ? componentWidth : componentHeight;
				contentFactorMoveValue = size / visibleItems;

				var perc =  Math.floor((draggerPosition/(scrollTrackSize-draggerSize)*(totalItems - visibleItems)));
				//console.log(- contentFactorMoveValue * perc);

				var prop = {};
				var animProp = orientation == 'horizontal' ? 'left' : 'top';

				prop[animProp] = - contentFactorMoveValue * perc + 'px';
				sliderHolder.stop().animate(prop,  {duration: 350, easing: 'easeOutSine'});

				return;	
			};

			var dif = draggerMouseClickValue - draggerPositionClicked;
			var dp = (draggerInitalPosition+dif);

			var segment = Math.floor((dp * totalItems)/ (scrollTrackSize - draggerSize));
			if(segment < 0) segment=0;
			else if(segment > totalItems-1) segment = totalItems-1;
			//console.log('segment = ', segment);

			var item = $(slideArr[segment]);
			//console.log(item[0].opened);
			if(item[0].opened) return;//prevent openSlide call while mouse down on dragger and no segment change


			if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);
			if(videoIsOn){
				if(isVimeo){
					forceVimeoEnd();
				}else{
					forceYoutubeEnd();
				}
			}

			hidePreviousSlideData(counter);
			counter = segment;
			openSlide(counter);
			if(!openOnRollover && slideArr[counter].action != undefined) checkSlideAction(counter);
		}

		//drag content only on segments change
		function updateContentViaScroll(navOff){
			if(!navOff){
				if(!navigationActive) return;
			}

			//console.log('updateContentViaScroll');

			var perc;

			var t = visibleItems;
			var t1 = Math.ceil(t / 2);
			var t2 = t - t1;
			var q = totalItems - visibleItems;

			if(counter < t1){//still zero
				perc = 0;
			}
			if(counter >= t1){//start count
				perc = counter - t2;
			}
			if(perc > q) {//upper limit
				perc = q;
			}


			var prop = {};
			var animProp = orientation == 'horizontal' ? 'left' : 'top';

			prop[animProp] = - contentFactorMoveValue * perc + 'px';
			//console.log('to ',  - contentFactorMoveValue);
			sliderHolder.stop().animate(prop,  {duration: 350, easing: 'easeOutSine'});
		}

		function updateContentViaScroll2(){
			if(!navigationActive) return;

			//console.log('updateContentViaScroll2');

			var perc;

			var t = visibleItems;
			var t1 = Math.ceil(t / 2);
			var t2 = t - t1;
			var q = totalItems - visibleItems;

			if(counter < t1){//still zero
				perc = 0;
			}
			if(counter >= t1){//start count
				perc = counter - t2;
			}
			if(perc > q) {//upper limit
				perc = q;
			}

			var prop = {};
			var animProp = orientation == 'horizontal' ? 'left' : 'top';

			var size = orientation == 'horizontal' ? componentWidth : componentHeight;
			contentFactorMoveValue = size / visibleItems;

			prop[animProp] = - contentFactorMoveValue * perc + 'px';
			sliderHolder.stop().animate(prop,  {duration: 350, easing: 'easeOutSine'});
		}

		function positionDraggerOnSegment(id){
			if(!navigationActive) return;

			var slidePart = scrollTrackSize / totalItems;
			draggerPosition = slidePart * id;

			if(draggerPosition<0) draggerPosition=0;
			else if(draggerPosition>(scrollTrackSize-draggerSize)) draggerPosition=(scrollTrackSize-draggerSize);

			var prop = {};
			var animProp = scrollOrientation == 'horizontal' ? 'left' : 'top';
			prop[animProp] = draggerPosition + 'px';

			dragger.stop().animate(prop,  {duration: 350, easing: "easeOutQuint"});

		}

		/*
		if(useMouseWheel){
			sliderWrapper.mousewheel(function(event, delta) {
				draggerPosition-=delta*10;
				updateSlidesViaScroll();
				return false;
			});
		}*/

		//************** END SCROLL

		function createPlayBtn(div) {//play btn for video slide

			var playBtn = $(new Image());
			playBtn.css('position', 'absolute');
			playBtn.css('display', 'block');
			div.append(playBtn);

			playBtn.load(function() {

				//console.log(this.width, this.height, div.customSize);

				playBtn.css('width', this.width + 'px');
				playBtn.css('height', this.height + 'px');

				if(orientation == 'horizontal'){
					playBtn.css('left', div.customSize / 2 - this.width / 2 + 'px');
					playBtn.css('top', componentHeight / 2 - this.height / 2 + 'px');
				}else{
					playBtn.css('left', componentWidth / 2 - this.width / 2 + 'px');
					playBtn.css('top', div.customSize / 2 - this.height / 2 + 'px');
				}

			}).attr('src', playBtnUrl);
		}

		//*****************




		 function openSlideOnClick(e) {
			overCategoryItem(e);
		 }

		 function overCategoryItem(e) {
			if(!componentInited) return;

			componentHit = true;

			if(slideshowOn) pauseSlideshow();

			if(videoIsOn) return;

			if (!e) var e = window.event;
			if(e.cancelBubble) e.cancelBubble = true;
			else if (e.stopPropagation) e.stopPropagation();

			var currentTarget = e.currentTarget;
			var id = $(currentTarget).attr('id');
			//console.log(slideArr[id].action);

			//check action for after_click_open 
			if(slideArr[id].action != undefined){
				checkSlideAction(id);
			}

			positionDraggerOnSegment(id);

		    if(currentTarget.opened) return;
		 	//console.log('overCategoryItem', id);

			hidePreviousSlideData(counter);
			counter=id;
			openSlide(counter, true);

			return false;

		}

		 function checkSlideAction(id) {
			 var type = slideArr[id].action;
			 var currentTarget = $(slideArr[id]);
			 if(type == 'link'){
				currentTarget.bind('click', navigateToUrl);
			 }else if(type == 'youtube'){
				currentTarget.bind('click', toggleYoutube);
			 }else if(type == 'vimeo'){
				currentTarget.bind('click', toggleVimeo);
			 }
		 }

		 function outCategoryItem(e) {
			if(!componentInited) return; 

			if (!e) var e = window.event;
			if(e.cancelBubble) e.cancelBubble = true;
			else if (e.stopPropagation) e.stopPropagation();

			var currentTarget = e.currentTarget;
			var id = $(currentTarget).attr('id');

			//console.log('outCategoryItem', id);
			if(!videoIsOn){
				if(slideshowOn){
					resumeSlideshow();
				}else{
					if(!keepSelection){
						hidePreviousSlideData(id);
						distributeSpace('tween');
					}
				}
			}
			componentHit = false;
			return false;
		}

		function hidePreviousSlideData(id) {//hide vertical title and captions
			if(id == -1) return;

			//check action for after_click_open 
			if(slideArr[id].action != undefined){
				var type = slideArr[id].action;
				var currentTarget = $(slideArr[id]);
				if(type == 'link'){
					currentTarget.unbind('click', navigateToUrl);
				}else if(type == 'youtube'){
					currentTarget.unbind('click', toggleYoutube);
				}else if(type == 'vimeo'){
					currentTarget.unbind('click', toggleVimeo);
				}
			}

			if(hideTitleOnOpen){
				var title=$(titleArr[id]);
				if(title){
					title.css('display', 'block');
					title.stop().animate({'opacity': 1},  {duration: 500, easing: "easeOutQuart"});
				}
			}

			removeCaptions(id);
		}

		function openSlide(j, updateContent) {
			//console.log('openSlide ', j);
			if(!componentInited) return;

			var item;
			var itemToMove = slideArr[j] ;
			var i = 0;
			var newX;
			var id;
			var size = orientation == 'horizontal' ? componentWidth : componentHeight;
			var cs = parseInt(itemToMove.customSize, 10);
			contentFactorMoveValue =( size - cs) / (visibleItems - 1);
			scrollContentSize = parseInt((cs + (contentFactorMoveValue * (totalItems-1))), 10);
			//console.log('contentFactorMoveValue = ', contentFactorMoveValue );

			var z = 0;
			var p = 0;
			var activeX = 0;

			var prop = {};
			var animProp = orientation == 'horizontal' ? 'left' : 'top';

			/*
			var thetop = "top";

			// create the object literal
			var aniArgs = {};

			// Assign the variable property name with a value of 10
			aniArgs[thetop] = 10; 

			// Pass the resulting object to the animate method
			obj.stop().animate(
				aniArgs, 10  
			);  
			*/

			for(i; i< playlistLength; i++) {

				item = $(slideArr[i]);
				id = item.attr('id');

				if(i < j){//before

					newX = p * contentFactorMoveValue;
					//console.log('before ', i, ' ', newX);
					prop[animProp] = newX + 'px';

					item.stop().animate(prop,  {duration: transitionTime, easing: transitionEase});

					p++;

					if(item.attr('id') != j){
						item[0].opened = false;
					}else{
						item[0].opened = true;
					}

				}
				else if(i == j)	{//active

					activeX = j * contentFactorMoveValue;
					//console.log('active ', i, ' ', newX);
					prop[animProp] = activeX + 'px';

					item.stop().animate(prop,  {duration: transitionTime, easing: transitionEase});

					if(item.attr('id') != j){
						item[0].opened = false;
					}else{
						item[0].opened = true;
					}

				}
				else if(i > j)	{//after

					newX = activeX + itemToMove.customSize + z * contentFactorMoveValue;
					//console.log('after ', i, ' ', newX);
					prop[animProp] = newX + 'px';

					item.stop().animate(prop,  {duration: transitionTime, easing: transitionEase});

					z++;

					if(item.attr('id') != j){
						item[0].opened = false;
					}else{
						item[0].opened = true;
					}

				}

			}

			if(!allSlidesVisible && updateContent) updateContentViaScroll(true);

			if(hideTitleOnOpen){
				var title=$(titleArr[j]);
				title.stop().animate({'opacity': 0},  {duration: 500, easing: "easeOutQuart", complete: function(){
					if(title) title.css('display', 'none');
				}});
			}

			if(captionStartTimeoutID) clearTimeout(captionStartTimeoutID);
			captionStartTimeoutID = setTimeout(function(){checkCaptions(j)},transitionTime-250);
		}

		function distributeSpace(tween) {

			var item;
			var i = 0;
			var newX;

			//on rollout if selection is false, calculate again spacing factor and align wole container as well
			if(openOnRollover && !keepSelection){
				var size = orientation == 'horizontal' ? componentWidth : componentHeight;
				scrollContentSize = parseInt((totalItems * (size / visibleItems)), 10);///unopened size
				//console.log('scrollContentSize = ', scrollContentSize);

				if(!allSlidesVisible) updateContentViaScroll2();
			}

			var factor = scrollContentSize / totalItems;

			var prop = {};
			var animProp = orientation == 'horizontal' ? 'left' : 'top';

			for(i; i< playlistLength; i++) {
				item = $(slideArr[i]);
				newX= i * factor;
				prop[animProp] = newX + 'px';

				item.stop().animate(prop,  {duration: tween ? transitionTime : 0, easing: transitionEase});
				item[0].opened = false;
			}

			counter=-1;//reset
		}


		function removeCaptions(id){
			//console.log('removeCaptions');

			if(captionStartTimeoutID) clearTimeout(captionStartTimeoutID);	

			if(!slideArr[id]) return;	
			if(slideArr[id].captions == undefined) return;	

			var i = 0;
			var captionArr = slideArr[id].captions;
			var len =captionArr.length;
			var caption;
			var xmove;

			for(i; i < len;i++){

				caption=captionArr[i];

				xmove=caption.origLeft+captionMoveValue  + 'px';

				$(caption).stop().animate({width: 0, left: xmove}, {
					duration: captionToggleSpeed, 
					easing: "easeOutQuint"
				});

			}

		}

		function checkCaptions(id){
			//console.log('checkCaptions');

			if(captionStartTimeoutID) clearTimeout(captionStartTimeoutID);

			if(!slideArr[id]) return;	
			if(slideArr[id].captions != undefined){

				var i = 0;
				var captionArr = slideArr[id].captions;
				var len =captionArr.length;
				var caption;
				var cfw;
				var cof;

				for(i; i < len;i++){

					caption=captionArr[i];

					if(i != len-1){

						cfw=caption.finalWidth + 'px';
						cof = caption.origLeft+ 'px';

						$(caption).delay(captionOpenDelay * i).animate({width: cfw, left: cof}, {
							duration: captionToggleSpeed, 
							easing: "easeOutQuint"
						});

					}else if(i == len -1){

						cfw=caption.finalWidth + 'px';
						cof = caption.origLeft+ 'px';

						$(caption).delay(captionOpenDelay * i).animate({width: cfw, left: cof }, {
						duration: captionToggleSpeed, 
						easing: "easeOutQuint",
						complete: function(){

							if(slideshowOn) checkSlideshow();

						}});

					}//if else

				}//for

			}else{

				if(slideshowOn) checkSlideshow();

			}

		}



		function openVimeo(link){
			if(!componentInited) return;

			videoIsOn=true;
			isVimeo=true;

			createCloseVideoBtn();

			vimeoHolderDiv.css('opacity', 0);
			vimeoHolderDiv.css('display', 'block');

			ytHolderDiv.css('zIndex', -10);
			vimeoHolderDiv.css('zIndex', 11);


			if(!vimeoInited){

				var videoIFramePath = link;
				var vimeoApi = '?api=1';
				var autoplay = '&autoplay=1';
				var videoIFrameSrc = 'http://player.vimeo.com/video/' + videoIFramePath + vimeoApi;
				//var videoIFrameSrc = 'http://player.vimeo.com/video/' + videoIFramePath + vimeoApi + '&player_id=player1';

				vimeoVideoIframe = $('<iframe />', {
					frameborder: 0,
					src: videoIFrameSrc,
					width: 100 + '%',
					height: 100 + '%'
				});

				vimeoHolderDiv.append(vimeoVideoIframe);

				vimeoPlayer = Froogaloop(vimeoVideoIframe[0]);
				vimeoPlayer.addEvent('ready', onVimeoReady);

				vimeoInited = true;

			}else{

				var videoIFramePath = link;
				var vimeoApi = '?api=1';
				var videoIFrameSrc = 'http://player.vimeo.com/video/' + videoIFramePath + vimeoApi;
				vimeoVideoIframe.attr('src', videoIFrameSrc);

			}

			 //if safari, fade in here
			 if(is_safari && !is_chrome){
				//console.log('is_safari = ', + is_safari);
				vimeoHolderDiv.css('opacity', 1);
				sliderHolder.css('opacity', 0);
				if(divClosingBorder) divClosingBorder.css('opacity', 0);
			}

			//sliderWrapper.append(closeVideoBtn);//above video
			//sliderWrapper.append(closeText);//above video
			vimeoHolderDiv.append(closeVideoBtn);//above video
			vimeoHolderDiv.append(closeText);//above video

			if(videoDisablesAllNavigation) hideNavigation();

		}

		function toggleVimeo(e){

			if (!e) var e = window.event;
			if(e.cancelBubble) e.cancelBubble = true;
			else if (e.stopPropagation) e.stopPropagation();

			var currentTarget = e.currentTarget;
			//var id = $(currentTarget).attr('id');

			if(videoDisablesAllNavigation) hideNavigation();

			var link = slideArr[counter].link;
			openVimeo(link);

			return false;

		}

		function createCloseVideoBtn(){

			//close btn

			var closeTextUrl = 'data/icons/close.png';
			var closeTextWidth=45;
			var closeTextHeight=35;

			var closeBtnX;
			if(isVimeo){
				closeBtnX = componentWidth - 110;
			}else{
				closeBtnX = componentWidth - 55;
			}
			var closeBtnY = 10;

			closeVideoBtn = $("<div></div>");
			closeVideoBtn.css('position', 'absolute');
			closeVideoBtn.css('width', closeTextWidth + 'px');
			closeVideoBtn.css('height', closeTextHeight + 'px');
			closeVideoBtn.css('left', closeBtnX + 'px');
			closeVideoBtn.css('top', closeBtnY + 'px');
			if(isVimeo){
				closeVideoBtn.attr('class', 'closeVimeoNormal');
			}else{
				closeVideoBtn.attr('class', 'closeYTNormal');

				closeVideoBtn.bind('click', clickCloseYTPlayer);

			}
			closeVideoBtn.css('opacity', 0);


			closeText = $(new Image());
			closeText.css('position', 'absolute');
			closeText.css('width', closeTextWidth + 'px');
			closeText.css('height', closeTextHeight + 'px');
			closeText.css('left', closeBtnX + 'px');
			closeText.css('top', closeBtnY + 'px');
			closeText.css('display', 'block');
			closeText.css('opacity', 0);
			closeText.css('cursor', 'pointer');

			closeText.load(function() {
			}).attr('src', closeTextUrl);


			closeText.bind('mouseover', overCloseVideoPlayer);
			closeText.bind('mouseout', outCloseVideoPlayer);
			if(isVimeo){
				closeText.bind('click', clickCloseVimeoPlayer);
			}else{
				closeText.bind('click', clickCloseYTPlayer);
			}

		}

		function onVimeoFinish(data){
			//console.log('onVimeoFinish');
			//if slideshow on && video in slideshow, close player and slide

			if(slideshowOn){
				clickCloseVimeoPlayer();
			}

		}

		 function onVimeoReady(playerID){
			//console.log('onVimeoReady');

			vimeoPlayer.addEvent('finish', onVimeoFinish);

			//var colorVal = Math.floor(Math.random() * 16777215).toString(16);
			//vimeoPlayer.setColor(colorVal);
			//console.log(vimeoPlayer.getColor());

			//show video
			vimeoHolderDiv.animate({opacity: 1 }, {
				duration: 1000, 
				easing: "easeOutSine"
			});

			//hide slider
			if(divClosingBorder) divClosingBorder.animate({opacity: 0 }, {duration: 1000,easing: "easeOutSine"});
			sliderHolder.animate({opacity: 0 }, {
				duration: 1000, 
				easing: "easeOutSine",
				complete: function(){
					sliderHolder.hide();

					//show close btn
					closeVideoBtn.css('opacity', closeVideoBtnOffOpacity);
					closeText.css('opacity', 1);

			}});

			if(videoAutoplay) vimeoPlayer.api('play');
		}



		function overSlider(e){//show close btn
			//console.log('overSlider');
			componentHit=true;
			if(slideshowOn) pauseSlideshow();
			if(!videoIsOn) return; 

			if(isVimeo){
				closeVideoBtn.css('opacity', closeVideoBtnOffOpacity);
			}else{
				closeVideoBtn.css('opacity', 1);
			}
			closeText.css('opacity', 1);
			return false;
		}

		function outSlider(e){//hide close btn
			//console.log('outSlider');
			componentHit=false;
			if(!videoIsOn){
				if(slideshowOn){
					resumeSlideshow();
				}
				return; 
			}

			closeVideoBtn.css('opacity', 0);
			closeText.css('opacity', 0);
			return false;
		}

		function overCloseVideoPlayer(e){
			if(isVimeo){
				closeVideoBtn.attr('class', 'closeVimeoOver');
			}else{
				closeVideoBtn.attr('class', 'closeYTOver');
			}
			closeVideoBtn.css('opacity', 1);
			return false;
		}

		function outCloseVideoPlayer(e){
			if(isVimeo){
				closeVideoBtn.attr('class', 'closeVimeoNormal');
			}else{
				closeVideoBtn.attr('class', 'closeYTNormal');
			}
			closeVideoBtn.css('opacity', closeVideoBtnOffOpacity);
			return false;
		}

		function clickCloseVimeoPlayer(){

			//clean
			//vimeoPlayer.removeEvent('ready', onVimeoReady);
			//vimeoPlayer.removeEvent('finish', onVimeoFinish);

			var offTime = 500;

			if(closeText){
				closeText.css('cursor', 'default');
				closeText.unbind('click', clickCloseVimeoPlayer);
				closeText.unbind('mouseover', overCloseVideoPlayer);
				closeText.unbind('mouseout', outCloseVideoPlayer);
			}

			//hide close btn
			if(closeVideoBtn) closeVideoBtn.css('opacity', 0);
			if(closeText) closeText.css('opacity', 0);

			//hide video
			vimeoHolderDiv.animate({opacity: 0 }, {
				duration: offTime, 
				easing: "easeOutSine"
			});

			//show slider
			sliderHolder.css('display', 'block');

			correctCustomContent();

			if(divClosingBorder) divClosingBorder.animate({opacity: 1 }, {duration: offTime,easing: "easeOutSine"});
			sliderHolder.animate({opacity: 1 }, {
				duration: offTime, 
				easing: "easeOutSine",
				complete: function(){

					//remove video
					vimeoPlayer.api('unload');
					vimeoVideoIframe.attr('src', '');

					vimeoHolderDiv.css('display', 'none');

					ytHolderDiv.css('zIndex', -10);
					vimeoHolderDiv.css('zIndex', -11);

					if(closeVideoBtn){
						closeVideoBtn.remove();
						closeVideoBtn=null;
					}
					if(closeText){
						closeText.remove();
						closeText=null;
					}

					videoIsOn=false;

					//check mouse hit component
					if(!componentHit){

						if(slideshowOn){
							counter++;
							if(counter>playlistLength - 1) counter=0;//loop
							openSlide(counter, true);
							positionDraggerOnSegment(counter);
							if(!openOnRollover && slideArr[counter].action != undefined) checkSlideAction(counter);
						}else{
							if(!keepSelection && openOnRollover){
								distributeSpace('tween');
							}
						}

					}

					if(videoDisablesAllNavigation) showNavigation();
					checkControls();
			}});

			return false;

		}

		function checkControls(){
			if(useControls){
				if(slideshowOn){
					controlsToggleSrc.attr('src', controls_pause_url);
				}else{
					controlsToggleSrc.attr('src', controls_play_url);
				}
			}
		}

		function forceVimeoEnd(){

			if(closeText){
				closeText.css('cursor', 'default');
				closeText.unbind('click', clickCloseVimeoPlayer);
				closeText.unbind('mouseover', overCloseVideoPlayer);
				closeText.unbind('mouseout', outCloseVideoPlayer);
			}

			//hide close btn
			if(closeVideoBtn) closeVideoBtn.css('opacity', 0);
			if(closeText) closeText.css('opacity', 0);

			//hide video
			vimeoHolderDiv.css('opacity', 0);

			//show slider
			sliderHolder.css('display', 'block');

			correctCustomContent();

			sliderHolder.css('opacity', 1);
			if(divClosingBorder) divClosingBorder.css('opacity', 1);

			//remove video
			vimeoPlayer.api('unload');
			vimeoVideoIframe.attr('src', '');

			vimeoHolderDiv.css('display', 'none');

			ytHolderDiv.css('zIndex', -10);
			vimeoHolderDiv.css('zIndex', -11);

			if(closeVideoBtn){
				closeVideoBtn.remove();
				closeVideoBtn=null;
			}
			if(closeText){
				closeText.remove();
				closeText=null;
			}

			videoIsOn=false;

			if(videoDisablesAllNavigation) showNavigation();
			checkControls();

		}

		//***********

		function toggleYoutube(e){
			if(!componentInited) return;

			if (!e) var e = window.event;
			if(e.cancelBubble) e.cancelBubble = true;
			else if (e.stopPropagation) e.stopPropagation();

			var currentTarget = e.currentTarget;
			//var id = $(currentTarget).attr('id');

			if(videoDisablesAllNavigation) hideNavigation();

			var link = slideArr[counter].link;
			openYoutube(link);

			return false;

		}

		function openYoutube(link){	
			//console.log('openYoutube ', link);

			videoIsOn=true;
			isVimeo=false;
			ytStarted = false;

			var videoid = slideArr[counter].link;

			createCloseVideoBtn();

			if(!ytInited){
				var youtubeApi = '?enablejsapi=1';
				var zindexfix='&amp;wmode=transparent';
				var videoIFrameSrc = 'http://www.youtube.com/embed/' + videoid + youtubeApi + zindexfix;

				var frameid= 'ytplayer';

				youtubeVideoIframe = $('<iframe />', {
					frameborder: 0,
					src: videoIFrameSrc,
					width: 100 + '%',
					height: 100 + '%',
					id: frameid
				});

				ytHolderDiv.append(youtubeVideoIframe);
				 YoutubePlayer(frameid,videoAutoplay, videoid);
				 ytInited =true;	

			}else{
				 YoutubePlayer(frameid,videoAutoplay, videoid);
			}

			if(ytStartIntervalID) clearInterval(ytStartIntervalID);
			if(!openYoutubeOnBuffering){
				 if(is_safari && !is_chrome){
					 showYTVideo();
				 }else if(!is_safari && is_chrome){
					 showYTVideo();
					 //console.log('fking chrome.........');
				 }else{
					 ytStartIntervalID = setInterval(checkYtStarted, ytStartInterval);
				 }
			}else{
				showYTVideo();
			}

			if(videoDisablesAllNavigation) hideNavigation();

		}

		function checkYtStarted(){
			if(ytPlayerState == 1){
				if(ytStartIntervalID) clearInterval(ytStartIntervalID);
				showYTVideo();
			}
		}

		function showYTVideo(){
			if(ytStartIntervalID) clearInterval(ytStartIntervalID);
			//console.log('showYTVideo');

			if(ytStarted) return;

			ytHolderDiv.css('opacity', 1);

			ytHolderDiv.css('zIndex', 11);
			vimeoHolderDiv.css('zIndex', -10);

			if(divClosingBorder) divClosingBorder.animate({opacity: 0 }, {duration: 500,easing: "easeOutSine"});
			sliderHolder.animate({opacity: 0 }, {
				duration: 500, 
				easing: "easeOutSine",
				complete: function(){
					sliderHolder.hide();

					//sliderWrapper.append(closeVideoBtn);
					//sliderWrapper.append(closeText);
					ytHolderDiv.append(closeVideoBtn);
					ytHolderDiv.append(closeText);

					//show close btn
					closeVideoBtn.css('opacity', closeVideoBtnOffOpacity);
					closeText.css('opacity', 1);

			}});

			ytStarted = true;

		}

		$.accordionGallery.ytEnd = function() {
			//console.log('yt end');
			if(slideshowOn){
				clickCloseYTPlayer();
			}
	    }

		function clickCloseYTPlayer(){
			//console.log('clickCloseYTPlayer')

			if(ytStartIntervalID) clearInterval(ytStartIntervalID);

			var offTime = 500;

			//clean
			if(closeText){
				closeText.css('cursor', 'default');
				closeText.unbind('click', clickCloseYTPlayer);
				closeText.unbind('mouseover', overCloseVideoPlayer);
				closeText.unbind('mouseout', outCloseVideoPlayer);
			}

			//show slider
			sliderHolder.css('display', 'block');

			correctCustomContent();

			if(divClosingBorder) divClosingBorder.animate({opacity: 1 }, {duration: offTime,easing: "easeOutSine"});
			sliderHolder.animate({opacity: 1 }, {
				duration: offTime, 
				easing: "easeOutSine",
				complete: function(){

					YoutubePlayerStop();
					ytHolderDiv.css('opacity', 0);

					ytHolderDiv.css('zIndex', -11);
					vimeoHolderDiv.css('zIndex', -10);

					if(closeVideoBtn){
						closeVideoBtn.remove();
						closeVideoBtn=null;
					}
					if(closeText){
						closeText.remove();
						closeText=null;
					}

					videoIsOn=false;

					//check mouse hit component
					if(!componentHit){

						if(slideshowOn){
							hidePreviousSlideData(counter);
							counter++;
							if(counter>playlistLength - 1) counter=0;//loop
							openSlide(counter, true);
							positionDraggerOnSegment(counter);
							if(!openOnRollover && slideArr[counter].action != undefined) checkSlideAction(counter);
						}else{
							if(!keepSelection && openOnRollover){
								distributeSpace('tween');
							}
						}

					}

					if(videoDisablesAllNavigation) showNavigation();
					checkControls();

			}});

			return false;

		}

		function forceYoutubeEnd(){

			if(ytStartIntervalID) clearInterval(ytStartIntervalID);

			//clean
			if(closeText){
				closeText.css('cursor', 'default');
				closeText.unbind('click', clickCloseYTPlayer);
				closeText.unbind('mouseover', overCloseVideoPlayer);
				closeText.unbind('mouseout', outCloseVideoPlayer);
			}

			//show slider
			sliderHolder.css('display', 'block');

			correctCustomContent();

			sliderHolder.css('opacity', 1);
			if(divClosingBorder) divClosingBorder.css('opacity', 1);

			YoutubePlayerStop();
			ytHolderDiv.css('opacity', 0);

			ytHolderDiv.css('zIndex', -11);
			vimeoHolderDiv.css('zIndex', -10);

			if(closeVideoBtn){
				closeVideoBtn.remove();
				closeVideoBtn=null;
			}
			if(closeText){
				closeText.remove();
				closeText=null;
			}

			videoIsOn=false;

			if(videoDisablesAllNavigation) showNavigation();
			checkControls();

		}




		//*********** CONTROLS

		function hideNavigation(){
			navigationActive=false;
			//console.log('hideNavigation');
			if(useControls) controls.animate({opacity: 0 }, {duration: 500, easing: "easeOutSine"});
			if(useScroll){
				_scroll.animate({opacity: 0 }, {duration: 500, easing: "easeOutSine"});
			}

		}

		function showNavigation(){

			if(useControls) controls.animate({opacity: 1 }, {duration: 500, easing: "easeOutSine"});
			if(useScroll){
				_scroll.animate({opacity: 1 }, {duration: 500, easing: "easeOutSine"});
			}
			navigationActive=true;
		}


		function clickControls(e){

			if (!e) var e = window.event;
			if(e.cancelBubble) e.cancelBubble = true;
			else if (e.stopPropagation) e.stopPropagation();

			if(!componentInited || !navigationActive) return;

			var currentTarget = e.currentTarget;
			var id = $(currentTarget).attr('class');

			if(id == 'controls_prev'){
				previousSlide(true);
			}
			else if(id == 'controls_toggle'){
				if(slideshowOn){
					if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);
					slideshowOn=false;
					if(useControls)controlsToggleSrc.attr('src', controls_play_url);
				}else{
					slideshowOn=true;
					if(useControls)controlsToggleSrc.attr('src', controls_pause_url);
					if(!videoIsOn){
						if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);
						slideshowTimeoutID = setTimeout(nextSlide, getSlideshowDelay());
					}
				}
			}
			else if(id == 'controls_next'){
				nextSlide(true);
			}

		}





		function checkSlideshow(){
			if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);

			if(includeVideoInSlideshow && slideArr[counter].action == 'vimeo'){
				//open video
				var link = slideArr[counter].link;
				openVimeo(link);

			}else if(includeVideoInSlideshow && slideArr[counter].action == 'youtube'){

				//open video
				var link = slideArr[counter].link;
				openYoutube(link);

			}else{
				if(slideshowOn && !componentHit){
					slideshowTimeoutID = setTimeout(nextSlide, getSlideshowDelay());
				}
			}
		}

		//find new delay for slide
		function getSlideshowDelay(){
			var nextDelay;
			var reserve= 3000;
			if(useGlobalDelay){
				//console.log('useGlobalDelay');
				nextDelay = slideshowTimeout > 0 ? slideshowTimeout : reserve;
			}else{
				var slide = $(dataArr[counter]);
				if(slide.attr('data-delay') != undefined){
					nextDelay = slide.attr('data-delay');
					//console.log('nextDelay = ', nextDelay);
				}else{
					nextDelay = slideshowTimeout > 0 ? slideshowTimeout : reserve;
				}
			}
			return nextDelay;
		}

		function pauseSlideshow(){
			if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);
			if(useControls)controlsToggleSrc.attr('src', controls_play_url);
		}

		function resumeSlideshow(){
			if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);
			slideshowTimeoutID = setTimeout(nextSlide, getSlideshowDelay());
			if(useControls)controlsToggleSrc.attr('src', controls_pause_url);
		}

		function nextSlide(forceVideoEnd){
			//console.log("nextSlide");
			if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);

			if(forceVideoEnd && videoIsOn){
				if(isVimeo){
					forceVimeoEnd();
				}else{
					forceYoutubeEnd();
				}
			}

			hidePreviousSlideData(counter);
			counter++;
			if(counter>playlistLength - 1) counter=0;//loop
			openSlide(counter, true);
			positionDraggerOnSegment(counter);
			if(!openOnRollover && slideArr[counter].action != undefined) checkSlideAction(counter);

		}

		function previousSlide(forceVideoEnd){
			//console.log("nextSlide");
			if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);

			if(forceVideoEnd && videoIsOn){
				if(isVimeo){
					forceVimeoEnd();
				}else{
					forceYoutubeEnd();
				}
			}

			hidePreviousSlideData(counter);
			counter--;
			if(counter<0) counter=playlistLength - 1;//loop
			openSlide(counter, true);
			positionDraggerOnSegment(counter);
			if(!openOnRollover && slideArr[counter].action != undefined) checkSlideAction(counter);

		}


			// ********** navigation  ********************* //


			function toggleScroll(on){
				var time=500;
				var ease='easeOutSine';
				if(on){
					dragger.css('opacity', 0);
					track.css('opacity', 0);
					dragger.css('display', 'block');
					track.css('display', 'block');
					_scroll.stop().animate({opacity: 1}, {duration: time, easing: ease});
				}else{
					_scroll.stop().animate({opacity: 0}, {duration: time, easing: ease, complete: function(){
						_scroll.css('display', 'none');
					}});
				}
			}

			function toggleControls(on){
				var time=500;
				var ease='easeOutSine';
				if(on){
					controls.css('opacity', 0);
					controls.css('display', 'block');
					controls.stop().animate({opacity: 1}, {duration: time, easing: ease});
				}else{
					controls.stop().animate({opacity: 0}, {duration: time, easing: ease, complete: function(){
						controls.css('display', 'none');
					}});
				}
			}






			// ********** HELPER FUNCTIONS ********************* //

			function navigateToUrl(e){
				if(!componentInited) return;

				if (!e) var e = window.event;
				if(e.cancelBubble) e.cancelBubble = true;
				else if (e.stopPropagation) e.stopPropagation();

				var currentTarget = e.currentTarget;
				var id = $(currentTarget).attr('id');
				var link = slideArr[id].link;
				//console.log('link = ', link);
				if(!link) return;

				var target=currentTarget.linkTarget;
				if(!target) target="_blank";
				//console.log(target);

				if(target=='_parent'){
					window.location=link;
				}else if(target=='_blank'){
					var newWindow=window.open(link, target);
					if (window.focus) {newWindow.focus();}
				}else{
					alert("Only _blank and _parent are allowed as target atributes for opening new url. You have set it to: " + target);
				}

				return false;
			}

			function preventSelect(arr){

				$(arr).each(function() {           
				$(this).attr('unselectable', 'on')
					   .css({
						   '-moz-user-select':'none',
						   '-webkit-user-select':'none',
						   'user-select':'none'
					   })
					   .each(function() {
						   this.onselectstart = function() { return false; };
					   });
				});

			}

			//returns a random value between min and max
			function randomMinMax(min, max){
				return Math.random() * (max - min) + min;
			}

			function shuffleArray(arr) {
				var i = 0;
				var len = arr.length;
				var temp;
				var randomNum;
				for (i; i < len; i++) {
					 temp = arr[i];
					 // generate a random number between (inclusive) 0 and the length of the array to shuffle
					 randomNum = Math.round(Math.random() * (len-1));
					 // the switch
					 arr[i] = arr[randomNum];
					 arr[randomNum] = temp;
				}
			}






			// ******************************** PUBLIC FUNCTIONS **************** //

			$.accordionGallery.stopSlideshow = function(forceVideoEnd) {
				if(!componentInited) return;
				if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);

				if(forceVideoEnd && videoIsOn){
					if(isVimeo){
						forceVimeoEnd();
					}else{
						forceYoutubeEnd();
					}
				}

				if(!keepSelection) distributeSpace('tween');
				slideshowOn=false;
				if(useControls)controlsToggleSrc.attr('src', controls_play_url);
			}

			$.accordionGallery.startSlideshow = function(forceVideoEnd) {
				if(!componentInited) return;
				if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);

				if(forceVideoEnd && videoIsOn){
					if(isVimeo){
						forceVimeoEnd();
					}else{
						forceYoutubeEnd();
					}
				}

				slideshowOn=true;
				nextSlide();
				if(useControls)controlsToggleSrc.attr('src', controls_pause_url);
			}

			$.accordionGallery.openSlideNum = function(num) {
				if(!componentInited) return;
				if(slideshowTimeoutID) clearTimeout(slideshowTimeoutID);

				if(videoIsOn){
					if(isVimeo){
						forceVimeoEnd();
					}else{
						forceYoutubeEnd();
					}
				}

				if(num<0) num=0;
				else if(num>playlistLength - 1) num=playlistLength-1;
				hidePreviousSlideData(counter);
				counter=num;
				openSlide(counter, true);
				positionDraggerOnSegment(counter);
				if(!openOnRollover && slideArr[counter].action != undefined) checkSlideAction(counter);
			}

			$.accordionGallery.openPreviousSlide = function() {
				previousSlide(true);
			}

			$.accordionGallery.openNextSlide = function() {
				nextSlide(true);
			}

			$.accordionGallery.setSlideshowDelay = function(delay) {
				if(!componentInited) return;
				if(delay<250) delay = 250;
				slideshowDelay = delay;
			}







		}

	})(jQuery);


