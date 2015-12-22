/**
 * SlideShow jQuery Plugin
 * - USAGE: $(selector).mainslider();
 */
(function(MODULES, $, undefined) {
    "use strict";
    var NAMESPACE = 'namespace.mainslider',
        ITEM_SELECTOR = 'div.visWrap',
        BULLET_SELECTOR = 'button.cir',
        IMAGE_SELECTOR = 'div.pic',
        TEXT_SELECTOR = 'div.txtWrap',
        AUTO_SELECTOR = 'button.anim';

    /*
     * ================================================================================
     * MainSlider
     * ================================================================================
     */
    /**
     * 생성자
     * @class MainSlider
     * @param {Mixed} container 컨텐이너
     * @param [options.imageEasing=easeInOutExpo] 이미지 모션 이징
     * @param [options.imageDuration=1500] 이미지 모션 시간
     * @param [options.textEasing=easeInCirc] 텍스트 모션 이징
     * @param [options.textDuration=700] 텍스트 모션 시간
     * @param [options.autoInterval=5000] 자동 간격
     */
    function MainSlider(container, options) {
        this.options = $.extend({
            imageEasing: 'easeInOutExpo',
            imageDuration: 1500,
            textEasing: 'easeInCirc',
            textDuration: 700,
            autoInterval: 5000
        }, options);

        this.$container = $(document.getElementById(container) || container);
        this.$items = this.$container.find(ITEM_SELECTOR);
        this.$bullets = this.$container.find(BULLET_SELECTOR);
        this.$images = this.$container.find(IMAGE_SELECTOR);
        this.$texts = this.$container.find(TEXT_SELECTOR);
        this.$auto = this.$container.find(AUTO_SELECTOR);
        
        this.autoPlayText = this.$auto.attr('data-play-text');
        this.autoStopText = this.$auto.attr('data-stop-text');
        this.size = this.$items.length;
        this.index = -1;
        this.start = 0;
        this.timer = -1;
        this.stopped = false;
        this.hovered = false;

        this.$container.prop('index', this.index);
        this._createDummy();
        this._bindEvent();
        this.move(0, true);
    }

    MainSlider.prototype = {
        /**
         * 더미 생성
         * @private
         * @function
         */
        _createDummy: function() {
            this.$container.remove('.d-mainslider-dummy');

            if (this.size > 1) {
                var $head = this.$items.last().clone().addClass('d-mainslider-dummy').removeClass('on'),
                    $tail = this.$items.first().clone().addClass('d-mainslider-dummy').removeClass('on');

                $head.find(BULLET_SELECTOR).remove();
                $tail.find(BULLET_SELECTOR).remove();

                this.$items.first().before($head);
                this.$items.last().after($tail);

                this.$images = this.$container.find(IMAGE_SELECTOR);
                this.$texts = this.$container.find(TEXT_SELECTOR);
                this.start = -1;
            }
        },
        /**
         * 이벤트 등록
         * @private
         * @function
         */
        _bindEvent: function() {
            var self = this;

            this.$container.off('.' + NAMESPACE);

            this.$container.on('mouseenter.' + NAMESPACE + ', mouseleave.' + NAMESPACE, function(event) {
                if (event.type === 'mouseenter') {
                    self.hovered = true;
                    self.stop(true);
                } else {
                    self.hovered = false;
                    self.play(true);
                }
            });

            this.$container.on('click.' + NAMESPACE, BULLET_SELECTOR, function(event) {
                self.move(self.$bullets.index(this));
            });

            this.$container.on('click.' + NAMESPACE, AUTO_SELECTOR, function(event) {
                self.toggle();
            });
        },
        /**
         * 갱신
         * @function
         */
        update: function() {
            var sel = (this.size + (this.index % this.size)) % this.size;

            this.$items.removeClass('on');
            this.$items.eq(sel).addClass('on');
        },
        /**
         * 이동
         * @function
         * @param {Number} idx 인덱스
         * @param {Boolean} [immediately=false] 즉시 여부
         */
        move: function(idx, immediately) {
            var self = this,
                opts = this.options,
                cur = this.$container.is(':animated') ? -1 : this.index,
                sel = (this.size + (idx % this.size)) % this.size,
                len = this.$images.length;

            if (sel !== this.index) {
                this.index = idx;
                this.update();
                this.stop(true);

                if (cur > -1) {
                    self.$texts.eq(cur - self.start).addClass('single').animate({ left: '-100%' }, {
                        easing: opts.textEasing,
                        duration: immediately ? 0 : opts.textDuration,
                        complete: function() {
                            $(this).removeClass('single').hide();
                        }
                    });
                }

                this.$container.stop(true).animate({ index: idx }, {
                    easing: opts.imageEasing,
                    duration: immediately ? 0 : opts.imageDuration,
                    step: function(now, tween) {
                        var i, p;

                        now = now % self.size;
                        if (now <= -1) {
                            now += self.size;
                        }

                        for (i = 0; i < len; i += 1) {
                            p = (i - now + self.start) * 100;

                            self.$images.eq(i).css('left', p + '%');
                            if (i !== cur - self.start) {
                                self.$texts.eq(i).not('.single').css('left', p + '%');
                            }
                        }
                    },
                    complete: function() {
                        self.index = sel;
                        self.$container.prop('index', sel);
                        self.$texts.fadeIn();
                        self.play(true);
                    }
                });
            }
        },
        /**
         * 이전
         * @function
         */
        prev: function() {
            if (this.index !== -1) {
                this.move(this.index - 1);
            }
        },
        /**
         * 다음
         * @function
         */
        next: function() {
            if (this.index !== -1) {
                this.move(this.index + 1);
            }
        },
        /**
         * 재생
         * @function
         * @param {Boolean} [resume=false] 다시 시작 여부
         */
        play: function(resume) {
            var self = this;

            clearTimeout(this.timer);
            this.timer = null;

            if (this.size && this.options.autoInterval > 0) {
                if (!resume) {
                    this.stopped = false;
                    this.$auto.removeClass('play').addClass('stop');
                    this.$auto.children().text(this.autoStopText);
                }

                if (!this.stopped && !this.hovered) {
                    this.timer = setTimeout($.proxy(this.next, this), this.options.autoInterval);
                }
            }
        },
        /**
         * 정지
         * @function
         * @param {Boolean} [pause=false] 일시 정지 여부
         */
        stop: function(pause) {
            clearTimeout(this.timer);
            this.timer = null;

            if (!pause) {
                this.stopped = true;
                this.$auto.removeClass('stop').addClass('play');
                this.$auto.children().text(this.autoPlayText);
            }
        },
        /**
         * 재생/정지 토글
         * @function
         */
        toggle: function() {
            if (this.stopped) {
                this.play();
            } else {
                this.stop();
            }
        }
    };

    /*
     * ================================================================================
     * 전역 변수 및 jQuery 플러그인 등록
     * ================================================================================
     */
    $.fn.mainslider = function(method) {
        var args = Array.prototype.slice.call(arguments, 1);

        return this.each(function() {
            var $this = $(this),
                module = $this.data(NAMESPACE);

            if (!module) {
                $this.data(NAMESPACE, new MainSlider($this, method));
            } else if (module[method]) {
                module[method].apply(module, args);
            } else {
                $.error('method does not exists');
            }
        });
    }

})({}, jQuery);
