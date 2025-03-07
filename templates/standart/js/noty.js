if(typeof Object.create !== 'function') {
    Object.create = function(o) {
        function F() {
        }

        F.prototype = o;
        return new F();
    };
}

var NotyObject = {

    init: function(options) {

        // Mix in the passed in options with the default options
        this.options = $.extend({}, $.noty.defaults, options);

        this.options.layout = (this.options.custom) ? $.noty.layouts['inline'] : $.noty.layouts[this.options.layout];

        if($.noty.themes[this.options.theme])
            this.options.theme = $.noty.themes[this.options.theme];
        else
            options.themeClassName = this.options.theme;

        delete options.layout;
        delete options.theme;

        this.options = $.extend({}, this.options, this.options.layout.options);
        this.options.id = 'noty_' + (new Date().getTime() * Math.floor(Math.random() * 1000000));

        this.options = $.extend({}, this.options, options);

        // Build the noty dom initial structure
        this._build();

        // return this so we can chain/use the bridge with less code.
        return this;
    }, // end init

    _build: function() {

        // Generating noty bar
        var $bar = $('<div class="noty_bar noty_type_' + this.options.type + '"></div>').attr('id', this.options.id);
        $bar.append(this.options.template).find('.noty_text').html(this.options.text);

        this.$bar = (this.options.layout.parent.object !== null) ? $(this.options.layout.parent.object).css(this.options.layout.parent.css).append($bar) : $bar;

        if(this.options.themeClassName)
            this.$bar.addClass(this.options.themeClassName).addClass('noty_container_type_' + this.options.type);

        // Set buttons if available
        if(this.options.buttons) {

            // If we have button disable closeWith & timeout options
            this.options.closeWith = [];
            this.options.timeout = false;

            var $buttons = $('<div/>').addClass('noty_buttons');

            (this.options.layout.parent.object !== null) ? this.$bar.find('.noty_bar').append($buttons) : this.$bar.append($buttons);

            var self = this;

            $.each(this.options.buttons, function(i, button) {
                var $button = $('<button/>').addClass((button.addClass) ? button.addClass : 'gray').html(button.text).attr('id', button.id ? button.id : 'button-' + i)
                    .attr('title', button.title)
                    .appendTo(self.$bar.find('.noty_buttons'))
                    .on('click', function(event) {
                        if($.isFunction(button.onClick)) {
                            button.onClick.call($button, self, event);
                        }
                    });
            });
        }

        // For easy access
        this.$message = this.$bar.find('.noty_message');
        this.$closeButton = this.$bar.find('.noty_close');
        this.$buttons = this.$bar.find('.noty_buttons');

        $.noty.store[this.options.id] = this; // store noty for api

    }, // end _build

    show: function() {

        var self = this;

        (self.options.custom) ? self.options.custom.find(self.options.layout.container.selector).append(self.$bar) : $(self.options.layout.container.selector).append(self.$bar);

        if(self.options.theme && self.options.theme.style)
            self.options.theme.style.apply(self);

        ($.type(self.options.layout.css) === 'function') ? this.options.layout.css.apply(self.$bar) : self.$bar.css(this.options.layout.css || {});

        self.$bar.addClass(self.options.layout.addClass);

        self.options.layout.container.style.apply($(self.options.layout.container.selector), [self.options.within]);

        self.showing = true;

        if(self.options.theme && self.options.theme.style)
            self.options.theme.callback.onShow.apply(this);

        if($.inArray('click', self.options.closeWith) > -1)
            self.$bar.css('cursor', 'pointer').one('click', function(evt) {
                self.stopPropagation(evt);
                if(self.options.callback.onCloseClick) {
                    self.options.callback.onCloseClick.apply(self);
                }
                self.close();
            });

        if($.inArray('hover', self.options.closeWith) > -1)
            self.$bar.one('mouseenter', function() {
                self.close();
            });

        if($.inArray('button', self.options.closeWith) > -1)
            self.$closeButton.one('click', function(evt) {
                self.stopPropagation(evt);
                self.close();
            });

        if($.inArray('button', self.options.closeWith) == -1)
            self.$closeButton.remove();

        if(self.options.callback.onShow)
            self.options.callback.onShow.apply(self);

        if (typeof self.options.animation.open == 'string') {
            self.$bar.css('height', self.$bar.innerHeight());
            self.$bar.on('click',function(e){
                self.wasClicked = true;
            });
            self.$bar.show().addClass(self.options.animation.open).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                if(self.options.callback.afterShow) self.options.callback.afterShow.apply(self);
                self.showing = false;
                self.shown = true;
                if(self.hasOwnProperty('wasClicked')){
                    self.$bar.off('click',function(e){
                        self.wasClicked = true;
                    });
                    self.close();
                }
            });

        } else {
            self.$bar.animate(
                self.options.animation.open,
                self.options.animation.speed,
                self.options.animation.easing,
                function() {
                    if(self.options.callback.afterShow) self.options.callback.afterShow.apply(self);
                    self.showing = false;
                    self.shown = true;
                });
        }

        // If noty is have a timeout option
        if(self.options.timeout)
            self.$bar.delay(self.options.timeout).promise().done(function() {
                self.close();
            });

        return this;

    }, // end show

    close: function() {

        if(this.closed) return;
        if(this.$bar && this.$bar.hasClass('i-am-closing-now')) return;

        var self = this;

        if(this.showing) {
            self.$bar.queue(
                function() {
                    self.close.apply(self);
                }
            );
            return;
        }

        if(!this.shown && !this.showing) { // If we are still waiting in the queue just delete from queue
            var queue = [];
            $.each($.noty.queue, function(i, n) {
                if(n.options.id != self.options.id) {
                    queue.push(n);
                }
            });
            $.noty.queue = queue;
            return;
        }

        self.$bar.addClass('i-am-closing-now');

        if(self.options.callback.onClose) {
            self.options.callback.onClose.apply(self);
        }

        if (typeof self.options.animation.close == 'string') {
            self.$bar.addClass(self.options.animation.close).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                if(self.options.callback.afterClose) self.options.callback.afterClose.apply(self);
                self.closeCleanUp();
            });
        } else {
            self.$bar.clearQueue().stop().animate(
                self.options.animation.close,
                self.options.animation.speed,
                self.options.animation.easing,
                function() {
                    if(self.options.callback.afterClose) self.options.callback.afterClose.apply(self);
                })
                .promise().done(function() {
                    self.closeCleanUp();
                });
        }

    }, // end close

    closeCleanUp: function() {

        var self = this;

        // Modal Cleaning
        if(self.options.modal) {
            $.notyRenderer.setModalCount(-1);
            if($.notyRenderer.getModalCount() == 0) $('.noty_modal').fadeOut(self.options.animation.fadeSpeed, function() {
                $(this).remove();
            });
        }

        // Layout Cleaning
        $.notyRenderer.setLayoutCountFor(self, -1);
        if($.notyRenderer.getLayoutCountFor(self) == 0) $(self.options.layout.container.selector).remove();

        // Make sure self.$bar has not been removed before attempting to remove it
        if(typeof self.$bar !== 'undefined' && self.$bar !== null) {

            if (typeof self.options.animation.close == 'string') {
                self.$bar.css('transition', 'all 100ms ease').css('border', 0).css('margin', 0).height(0);
                self.$bar.one('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', function() {
                    self.$bar.remove();
                    self.$bar = null;
                    self.closed = true;

                    if(self.options.theme.callback && self.options.theme.callback.onClose) {
                        self.options.theme.callback.onClose.apply(self);
                    }
                });
            } else {
                self.$bar.remove();
                self.$bar = null;
                self.closed = true;
            }
        }

        delete $.noty.store[self.options.id]; // deleting noty from store

        if(self.options.theme.callback && self.options.theme.callback.onClose) {
            self.options.theme.callback.onClose.apply(self);
        }

        if(!self.options.dismissQueue) {
            // Queue render
            $.noty.ontap = true;

            $.notyRenderer.render();
        }

        if(self.options.maxVisible > 0 && self.options.dismissQueue) {
            $.notyRenderer.render();
        }

    }, // end close clean up

    setText: function(text) {
        if(!this.closed) {
            this.options.text = text;
            this.$bar.find('.noty_text').html(text);
        }
        return this;
    },

    setType: function(type) {
        if(!this.closed) {
            this.options.type = type;
            this.options.theme.style.apply(this);
            this.options.theme.callback.onShow.apply(this);
        }
        return this;
    },

    setTimeout: function(time) {
        if(!this.closed) {
            var self = this;
            this.options.timeout = time;
            self.$bar.delay(self.options.timeout).promise().done(function() {
                self.close();
            });
        }
        return this;
    },

    stopPropagation: function(evt) {
        evt = evt || window.event;
        if(typeof evt.stopPropagation !== "undefined") {
            evt.stopPropagation();
        }
        else {
            evt.cancelBubble = true;
        }
    },

    closed : false,
    showing: false,
    shown  : false

}; // end NotyObject

$.notyRenderer = {};

$.notyRenderer.init = function(options) {

    // Renderer creates a new noty
    var notification = Object.create(NotyObject).init(options);

    if(notification.options.killer)
        $.noty.closeAll();

    (notification.options.force) ? $.noty.queue.unshift(notification) : $.noty.queue.push(notification);

    $.notyRenderer.render();

    return ($.noty.returns == 'object') ? notification : notification.options.id;
};

$.notyRenderer.render = function() {

    var instance = $.noty.queue[0];

    if($.type(instance) === 'object') {
        if(instance.options.dismissQueue) {
            if(instance.options.maxVisible > 0) {
                if($(instance.options.layout.container.selector + ' > li').length < instance.options.maxVisible) {
                    $.notyRenderer.show($.noty.queue.shift());
                }
                else {

                }
            }
            else {
                $.notyRenderer.show($.noty.queue.shift());
            }
        }
        else {
            if($.noty.ontap) {
                $.notyRenderer.show($.noty.queue.shift());
                $.noty.ontap = false;
            }
        }
    }
    else {
        $.noty.ontap = true; // Queue is over
    }

};

$.notyRenderer.show = function(notification) {

    if(notification.options.modal) {
        $.notyRenderer.createModalFor(notification);
        $.notyRenderer.setModalCount(+1);
    }

    // Where is the container?
    if(notification.options.custom) {
        if(notification.options.custom.find(notification.options.layout.container.selector).length == 0) {
            notification.options.custom.append($(notification.options.layout.container.object).addClass('i-am-new'));
        }
        else {
            notification.options.custom.find(notification.options.layout.container.selector).removeClass('i-am-new');
        }
    }
    else {
        if($(notification.options.layout.container.selector).length == 0) {
            $('body').append($(notification.options.layout.container.object).addClass('i-am-new'));
        }
        else {
            $(notification.options.layout.container.selector).removeClass('i-am-new');
        }
    }

    $.notyRenderer.setLayoutCountFor(notification, +1);

    notification.show();
};

$.notyRenderer.createModalFor = function(notification) {
    if($('.noty_modal').length == 0) {
        var modal = $('<div/>').addClass('noty_modal').addClass(notification.options.theme).data('noty_modal_count', 0);

        if(notification.options.theme.modal && notification.options.theme.modal.css)
            modal.css(notification.options.theme.modal.css);

        modal.prependTo($('body')).fadeIn(notification.options.animation.fadeSpeed);

        if($.inArray('backdrop', notification.options.closeWith) > -1)
            modal.on('click', function(e) {
                $.noty.closeAll();
            });
    }
};

$.notyRenderer.getLayoutCountFor = function(notification) {
    return $(notification.options.layout.container.selector).data('noty_layout_count') || 0;
};

$.notyRenderer.setLayoutCountFor = function(notification, arg) {
    return $(notification.options.layout.container.selector).data('noty_layout_count', $.notyRenderer.getLayoutCountFor(notification) + arg);
};

$.notyRenderer.getModalCount = function() {
    return $('.noty_modal').data('noty_modal_count') || 0;
};

$.notyRenderer.setModalCount = function(arg) {
    return $('.noty_modal').data('noty_modal_count', $.notyRenderer.getModalCount() + arg);
};

// This is for custom container
$.fn.noty = function(options) {
    options.custom = $(this);
    return $.notyRenderer.init(options);
};

$.noty = {};
$.noty.queue = [];
$.noty.ontap = true;
$.noty.layouts = {};
$.noty.themes = {};
$.noty.returns = 'object';
$.noty.store = {};

$.noty.get = function(id) {
    return $.noty.store.hasOwnProperty(id) ? $.noty.store[id] : false;
};

$.noty.close = function(id) {
    return $.noty.get(id) ? $.noty.get(id).close() : false;
};

$.noty.setText = function(id, text) {
    return $.noty.get(id) ? $.noty.get(id).setText(text) : false;
};

$.noty.setType = function(id, type) {
    return $.noty.get(id) ? $.noty.get(id).setType(type) : false;
};

$.noty.clearQueue = function() {
    $.noty.queue = [];
};

$.noty.closeAll = function() {
    $.noty.clearQueue();
    $.each($.noty.store, function(id, noty) {
        noty.close();
    });
};

var windowAlert = window.alert;

$.noty.consumeAlert = function(options) {
    window.alert = function(text) {
        if(options)
            options.text = text;
        else
            options = {text: text};

        $.notyRenderer.init(options);
    };
};

$.noty.stopConsumeAlert = function() {
    window.alert = windowAlert;
};

$.noty.defaults = {
    layout      : 'top',
    theme       : 'defaultTheme',
    type        : 'alert',
    text        : '',
    dismissQueue: true,
    template    : '<div class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>',
    animation   : {
        open  : {height: 'toggle'},
        close : {height: 'toggle'},
        easing: 'swing',
        speed : 500,
        fadeSpeed: 'fast',
    },
    timeout     : false,
    force       : false,
    modal       : false,
    maxVisible  : 5,
    killer      : false,
    closeWith   : ['click'],
    callback    : {
        onShow      : function() {
        },
        afterShow   : function() {
        },
        onClose     : function() {
        },
        afterClose  : function() {
        },
        onCloseClick: function() {
        }
    },
    buttons     : false
};

$(window).on('resize', function() {
    $.each($.noty.layouts, function(index, layout) {
        layout.container.style.apply($(layout.container.selector));
    });
});

// Helpers
window.noty = function noty(options) {
    return $.notyRenderer.init(options);
};

$.noty.layouts.bottomRight = {
    name     : 'bottomRight',
    options  : { // overrides options

    },
    container: {
        object  : '<ul id="noty_bottomRight_layout_container" />',
        selector: 'ul#noty_bottomRight_layout_container',
        style   : function() {
            $(this).css({
                bottom       : 10,
                right        : 10,
                position     : 'fixed',
                width        : '310px',
                height       : 'auto',
                margin       : 0,
                padding      : 0,
                listStyleType: 'none',
                zIndex       : 10000000
            });

            if(window.innerWidth < 600) {
                $(this).css({
                    right: 5
                });
            }
        }
    },
    parent   : {
        object  : '<li />',
        selector: 'li',
        css     : {}
    },
    css      : {
        display: 'none',
        width  : '310px'
    },
    addClass : ''
};

$.noty.themes.relax = {
    name    : 'relax',
    helpers : {},
    modal   : {
        css: {
            position       : 'fixed',
            width          : '100%',
            height         : '100%',
            backgroundColor: '#000',
            zIndex         : 10000,
            opacity        : 0.6,
            display        : 'none',
            left           : 0,
            top            : 0
        }
    },
    style   : function() {

        this.$bar.css({
            overflow    : 'hidden',
            margin      : '4px 0',
            borderRadius: '2px'
        });

        this.$message.css({
            fontSize  : '14px',
            lineHeight: '16px',
            textAlign : 'center',
            padding   : '0',
            width     : 'auto',
            position  : 'relative'
        });

        this.$closeButton.css({
            position  : 'absolute',
            top       : 4, right: 4,
            width     : 10, height: 10,
            background: "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAQAAAAnOwc2AAAAxUlEQVR4AR3MPUoDURSA0e++uSkkOxC3IAOWNtaCIDaChfgXBMEZbQRByxCwk+BasgQRZLSYoLgDQbARxry8nyumPcVRKDfd0Aa8AsgDv1zp6pYd5jWOwhvebRTbzNNEw5BSsIpsj/kurQBnmk7sIFcCF5yyZPDRG6trQhujXYosaFoc+2f1MJ89uc76IND6F9BvlXUdpb6xwD2+4q3me3bysiHvtLYrUJto7PD/ve7LNHxSg/woN2kSz4txasBdhyiz3ugPGetTjm3XRokAAAAASUVORK5CYII=)",
            display   : 'none',
            cursor    : 'pointer'
        });

        this.$buttons.css({
            padding        : 5,
            textAlign      : 'right',
            borderTop      : '1px solid #ccc',
            backgroundColor: '#fff'
        });

        this.$buttons.find('button').css({
            marginLeft: 5
        });

        this.$buttons.find('button:first').css({
            marginLeft: 0
        });

        this.$bar.on({
            mouseenter: function() {
                $(this).find('.noty_close').stop().fadeTo('normal', 1);
            },
            mouseleave: function() {
                $(this).find('.noty_close').stop().fadeTo('normal', 0);
            }
        });

        switch(this.options.layout.name) {
            case 'top':
                this.$bar.css({
                    borderBottom: '2px solid #eee',
                    borderLeft  : '2px solid #eee',
                    borderRight : '2px solid #eee',
                    borderTop   : '2px solid #eee',
                    boxShadow   : "0 2px 4px rgba(0, 0, 0, 0.1)"
                });
                break;
            case 'topCenter':
            case 'center':
            case 'bottomCenter':
            case 'inline':
                this.$bar.css({
                    border   : '1px solid #eee',
                    boxShadow: "0 2px 4px rgba(0, 0, 0, 0.1)"
                });
                this.$message.css({fontSize: '13px', textAlign: 'center'});
                break;
            case 'topLeft':
            case 'topRight':
            case 'bottomLeft':
            case 'bottomRight':
            case 'centerLeft':
            case 'centerRight':
                this.$bar.css({
                    border   : '1px solid #eee',
                    boxShadow: "0 2px 4px rgba(0, 0, 0, 0.1)"
                });
                this.$message.css({fontSize: '13px', textAlign: 'left'});
                break;
            case 'bottom':
                this.$bar.css({
                    borderTop   : '2px solid #eee',
                    borderLeft  : '2px solid #eee',
                    borderRight : '2px solid #eee',
                    borderBottom: '2px solid #eee',
                    boxShadow   : "0 -2px 4px rgba(0, 0, 0, 0.1)"
                });
                break;
            default:
                this.$bar.css({
                    border   : '2px solid #eee',
                    boxShadow: "0 2px 4px rgba(0, 0, 0, 0.1)"
                });
                break;
        }

        switch(this.options.type) {
            case 'alert':
            case 'notification':
                this.$bar.css({backgroundColor: '#FFF', borderColor: '#dedede', color: '#444'});
                break;
            case 'warning':
                this.$bar.css({backgroundColor: '#FFEAA8', borderColor: '#FFC237', color: '#826200'});
                this.$buttons.css({borderTop: '1px solid #FFC237'});
                break;
            case 'error':
                this.$bar.css({backgroundColor: '#FF8181', borderColor: '#e25353', color: '#FFF'});
                this.$message.css({fontWeight: 'bold'});
                this.$buttons.css({borderTop: '1px solid darkred'});
                break;
            case 'information':
                this.$bar.css({backgroundColor: '#78C5E7', borderColor: '#3badd6', color: '#FFF'});
                this.$buttons.css({borderTop: '1px solid #0B90C4'});
                break;
            case 'success':
                this.$bar.css({backgroundColor: '#BCF5BC', borderColor: '#7cdd77', color: 'darkgreen'});
                this.$buttons.css({borderTop: '1px solid #50C24E'});
                break;
            default:
                this.$bar.css({backgroundColor: '#FFF', borderColor: '#CCC', color: '#444'});
                break;
        }
    },
    callback: {
        onShow : function() {

        },
        onClose: function() {

        }
    }
};

function show_noty(style, type, text, close) {
	var n = noty({
		text        : text,
		type        : type,
		dismissQueue: true,
		layout      : 'bottomRight',
		closeWith   : ['click'],
		theme       : 'relax',
		maxVisible  : 10,
		animation   : {
			open  : 'animated fadeIn'+style,
			close : 'animated fadeOut'+style,
			easing: 'swing',
			speed : 100
		}
	});
	if(close != '') {
		setTimeout(function () {
			n.close();
		}, close);
	}
}