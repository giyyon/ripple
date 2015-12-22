$(document).ready(function(){
	// visual 
	var VISUAL = (function(){
		var $container = $( '#container' ),
			$target = $('.ul_visual li'),
			$pos = $('.area_visual .ul_pos'),
			$btn = $('.ul_play'),
			$btnPrev = $('.ul_arrow .li_prev'),
			$btnNext = $('.ul_arrow .li_next'),
			$btnPlay = $('.ul_play li'),
			$btnStart = $('.ul_play .li_start a'),
			$btnStop = $('.ul_play .li_stop a'),
			$size = $target.size(),
			$margin = ((18 * ($size - 1)) / 2) * -1,
			$visualTxt = $('.ul_visual li .txt'),
			$cur = 0,
			$old = 0,
			$conCur = 0,
			$conOld = 0,
			$range = 100,
			$interval = 8000,
			$flag = true,
			$flag_global = true,
			// 2014-06-05 수정 start
			$dulation = 1200,
			$dulation1 = 1400,
			$dulation2 = 1800,
			$delay1 = 100,
			$delay2 = 300,
			$delay3 = 500,
			$delay4 = 800,
			$easing1 = 'easeOutQuad',
			$easing2 = 'easeInQuad',
			$arrTxt1 = [23.5,17.5,8.5,15,10],
			$arrTxt2 = [41,42.5,35.5,43.5,25.5],
			$arrImg1 = [0,96,-26,6,6],
			$arrImg2 = [96,-5,-5,6,6],
			$arrImg1_1 = [-70,-70,20,-70,-70],
			$arrImg2_1 = [0,20,20,-70,0],
			// 2014-06-05 수정 end
			$window = $( window ).width(),
			$mobilTemp = false,
			$conTarget1 = $('.box_main_content_1'),
			$conTarget2 = $('.box_main_content_1 > div'),
			$conSize = $conTarget2.size(),
			$conMargin = ((18 * ($conSize)) / 2) * -1;
		// 이미지 갯수대로 추가
		for (var i = 0; i < $size; i++){
			$pos.append('<li><a href="#wrap">' +  i + '</a></li>');
			$target.eq(i).css({ display : 'block' , left : i * 100 + '%'});
		}
		// 비주얼 텍스트 처음 한번 이동
		// 2014-06-05 수정 start
		$( window ).one('load',function(){
			$target.find('p').not('.img_opa').css({ display : 'block' , opacity :'0' });
			if ( $mobileTemp == false ){
				$target.eq(0).find('.txt_1').delay($delay1).animate({ opacity : 1 , top : $arrTxt1[0] + 7.5 + '%' },$dulation,$easing1);
				$target.eq(0).find('.txt_2').delay($delay2).animate({ opacity : 1 , top : $arrTxt2[0] + 7.5 + '%' },$dulation,$easing1);
				$('.area_visual .ul_visual li .img_4').css({ display : 'block' , opacity :'1' });
				$('.area_visual .ul_visual li .img_5').css({ display : 'block' , opacity :'1' });
				$('.area_visual .ul_visual li .img_6').css({ display : 'block' , opacity :'1' });
			} else {
				$('.area_visual .ul_visual li .txt_1').css({ display : 'block' , opacity : '1' });
				$('.area_visual .ul_visual li .img_4').css({ display : 'none' , opacity :'1' });
				$('.area_visual .ul_visual li .img_5').css({ display : 'none' , opacity :'1' });
				$('.area_visual .ul_visual li .img_6').css({ display : 'none' , opacity :'1' });
			}
		});
		// 2014-06-05 수정 end
		$pos.find('.hid').remove();
		$pos.css({ marginLeft :  $margin });
		$pos.find('li').eq($cur).addClass('on');
		$btn.css({ marginLeft : $margin - 18 });
		// 롤링 우로이동
		$btnPrev.bind('click',function(){
			if ($flag == true){
				$autoRollVisual();
			}
			rollVisual('prev');
			return false;
		});
		// 롤링 좌로이동
		$btnNext.bind('click',function(){
			if ($flag == true){
				$autoRollVisual();
			}
			rollVisual('next');
			return false;
		});
		// 롤링 정지
		$btnStop.bind('click',function(){
			clearInterval($rollVisual);
			$btnPlay.removeClass('on');
			$(this).parent().prev().addClass('on');
			$flag = false;
			return false;
		});
		// 롤링 시작
		$btnStart.bind('click',function(){
			$autoRollVisual();
			$btnPlay.removeClass('on');
			$(this).parent().next().addClass('on');
			$flag = true;
			return false;
		});
		// dot 클릭
		$(document).on('click','.ul_pos li:not(.on) a',function(){
			var $this = $(this),
				$index = $this.parent().index();
			if ($flag == true){
				$autoRollVisual();
			}
			rollVisual($index);
			return false;
		});
		// 스크롤시 텍스트
		$( window ).bind('scroll',function(){
			var $topTarget = $('.area_header'),
				$scrollTop = $( window ).scrollTop(),
				$mrgTop = 0,
				$opa = 0,
				$easing1 = 'easeOutQuad',
				$easing2 = 'easeInQuad',
				$winWidth = $( window ).width(),
				$top = $( window ).scrollTop();
			$mrgTop = ($scrollTop / 350) * -80;
			$opa = 1 - ($scrollTop / 350);
			if ( $scrollTop < 350 ) {
				$visualTxt.stop().animate({ marginTop : $mrgTop , 'opacity' : $opa },300,$easing1);
			}
			if ( $winWidth > 560 ){
				if ( $top > 350 ) {
					$topTarget.stop().animate({ top : '-36px' },300,$easing2);
				} else {
					$topTarget.stop().animate({ top : '0' },300,$easing1);
				}
			};
		});
		function rollVisual(direc){
			$old = $cur;
			if ( direc == 'prev' ){
				$cur--;
				$range = 100;
			} else if ( direc == 'next' ){
				$cur++;
				$range = -100;
			} else {
				$cur = direc;
			}
			if ( $cur < 0 ) {
				$cur = $size - 1;
			} else if ( $cur > $size - 1 ) {
				$cur = 0;
			}
			$pos.find('li').eq($old).removeClass('on');
			$pos.find('li').eq($cur).addClass('on');
			$target.eq($old).stop().animate({ left : $range + '%' },400,$easing2,function(){
				txtAni($old,$arrTxt1[$old],$arrTxt2[$old],$arrImg1[$old],$arrImg2[$old],'off');
			});
			$target.eq($cur).find('.txt_1').css('opacity','0');
			if ( $mobileTemp == false ){
				$target.eq($cur).find('.txt_2').css('opacity','0');
			}
			$target.eq($cur).css({ left : (-1 * $range) + '%' }).stop().animate({ left : '0' },400,$easing1,function(){
				txtAni($cur,$arrTxt1[$cur],$arrTxt2[$cur],$arrImg1[$cur],$arrImg2[$old],'on');
			});
		}
		// 비주얼 자동 롤링
		var $rollVisual = setInterval(function(){
			rollVisual('next');
		},$interval);
		function $autoRollVisual() {
			clearInterval($rollVisual);
			$rollVisual = setInterval(function(){
				rollVisual('next');
			},$interval);
		}
		// 텍스트 애니
		// 2014-06-05 수정 start
		function txtAni(idx,top1,top2,top3,top4,sta){
			switch (sta){
				case 'on':
					$target.eq(idx).find('.txt_1').stop().delay($delay1).animate({ opacity : 1 , top : top1 + 7.5 + '%'},$dulation,$easing1);
					if ( $mobileTemp == false ){
						$target.eq(idx).find('.txt_2').stop().delay($delay2).animate({ opacity : 1 , top : top2 + 7.5 + '%' },$dulation,$easing1);
						$target.eq(idx).find('.img_1').stop().delay($delay3).animate({ opacity : 1 , top : top3 + $arrImg1_1[idx] + '%' },$dulation,$easing2);
						if ($target.eq(idx).find('.img_2').length){
							$target.eq(idx).find('.img_2').stop().delay($delay4).animate({ opacity : 1 , top : top4 + $arrImg2_1[idx - 1] + '%' },$dulation1,$easing2);
						}
						if ($target.eq(idx).find('.img_3').length){
							$target.eq(idx).find('.img_3').stop().delay($delay3).animate({ opacity : 1 , width : top3 + 27 + '%' },$dulation,$easing1);
						}
						if ($target.eq(idx).find('.img_5').length){
							$target.eq(idx).find('.img_5').stop().delay($delay3).animate({ opacity : 1 , height : '0%' },$dulation2,$easing1);
						}
						if ($target.eq(idx).find('.img_6').length){
							$target.eq(idx).find('.img_6').stop().delay($delay4 + 400).animate({ opacity : 1 , width : top3 + 62 + 'px' },$dulation2,$easing1);
						}
					}
				break;
				case 'off':
					$target.eq(idx).find('.txt_1').stop().css({ opacity : 0 , top : top1 + '%' });
					if ( $mobileTemp == false ){
						$target.eq(idx).find('.txt_2').stop().css({ opacity : 0 , top : top2 + '%' });
						$target.eq(idx).find('.img_1').stop().css({ opacity : 0 , top : top3 + '%' });
						$target.eq(idx).find('.img_1.img_opa').stop().css({ opacity : 1 , top : top3 + '%' });
						if ($target.eq(idx).find('.img_2').length){
							$target.eq(idx).find('.img_2').stop().css({ opacity : 1 , top : top4 + '%' });
						}
						if ($target.eq(idx).find('.img_3').length){
							$target.eq(idx).find('.img_3').stop().css({ opacity : 0 , width : top3 + '%' });
						}
						if ($target.eq(idx).find('.img_5').length){
							$target.eq(idx).find('.img_5').stop().css({ opacity : 1 , height : '100%' });
						}
						if ($target.eq(idx).find('.img_6').length){
							$target.eq(idx).find('.img_6').stop().css({ opacity : 0 , width : 0 + 'px' });
						}
					}
				break;
			}
		}
		// 2014-06-05 수정 end
		// 롤링 모바일 정지
		$('.gnb_tit a').bind('click',function(){
			var $target = $('.box_mot_1');
			if ($target.hasClass('on')){
				clearInterval($rollVisual);
			} else {
				$autoRollVisual();
			}
		});
		// 글로벌 네트워크 모바일 위치 이동
		changeCon($window);
		function changeCon(size){
			var $target = $('.box_main_content_4_2'),
				$clone = $target.clone(),
				$append = $('.box_sns').next('.box_main_content_4_1'),
				$size = $('.box_main_content_1 > div').size();
			if ( size > 465 ){
				$mobileTemp = false;
				$('.area_visual .ul_visual li p').not('.txt_1').css('display','block');
				$('.box_main_content_1 > div').css('left','auto');
				$('.img_blank').remove();
			} else {
				$mobileTemp = true;
				for (var i = 0; i < $size; i++){
					$('.box_main_content_1 > div').eq(i).css('left',i * 100 + '%');
				}
				$('.area_visual .ul_visual li p').not('.txt_1').css('display','none');
				if (!$('.img_blank').length){
					$('.area_visual').append('<p class="img_blank"><img src="/common/img/common/blank.png" alt="" /></p>');
				}
			}
			if ( $flag_global == false && $window > 480 ){
				$append.next('.box_main_content_4_2').remove();
				$target.removeClass('off');
				$flag_global = true;
			} else if ($flag_global == true && $window < 480 ){
				$target.addClass('off');
				$append.after($clone);
				$flag_global = false;
			}
		}
		// 리사이즈 이벤트
		$( window ).bind('resize',function(e){
			clearTimeout(resizeEvt);
			var resizeEvt = setTimeout(function() {
				$window = $( window ).width();
				changeCon($window);
			}, 200);
		});
		// swipe 설정
		if ( 'ontouchstart' in window ) {
			// 메인 비주얼
			var gesture1 = new ixGuesture( jQuery('.area_visual')[0], 'horizontal', { onSwipe: swipeHandler1 } );
			gesture1.areaWidth( $container.width() );
			gesture1.sensitivity( 0.1 );
			// 메인 컨텐츠
			var gesture2 = new ixGuesture( jQuery('.box_main_content_1')[0], 'horizontal', { onSwipe: swipeHandler2 } );
			gesture2.areaWidth( $container.width() );
			gesture2.sensitivity( 0.1 );
		}
		// 컨텐츠 갯수대로 추가
		for (var i = 0; i < $conSize; i++){
			$('.box_main_content_1 .ul_pos').css( 'margin-left' , $conMargin ).append('<li><span>' +  i + '</span></li>');
			$('.box_main_content_1 .ul_pos li.hid').remove();
			if (i == 0 ){
				$('.box_main_content_1 .ul_pos li').eq(0).addClass('on');
			}
		}
		// 메인 비주얼 스와이프
		function swipeHandler1 (e) {
			if ($mobileTemp == true) {
				switch ( e.swipeType ) {
					case 'right' :
						if ($flag == true){
							$autoRollVisual();
						}
						rollVisual('prev');
					break;
					case 'left' :
						if ($flag == true){
							$autoRollVisual();
						}
						rollVisual('next');
					break;
				}
			}
		}
		//  메인 컨텐츠 스와이프
		function swipeHandler2 (e) {
			if ($mobileTemp == true) {
				switch ( e.swipeType ) {
					case 'right' :
						rollContent('prev');
					break;
					case 'left' :
						rollContent('next');
					break;
				}
			}
		}
		//  메인 컨텐츠 스와이프
		function rollContent(direc) {
			$conOld = $conCur;
			switch( direc ){
				case 'prev' :
					$conCur--;
					$conRange = 100;
				break;
				case 'next' :
					$conCur++;
					$conRange = -100;
				break;
			}
			if ( $conCur < 0 ) {
				$conCur = $conSize - 1;
			} else if ( $conCur > $conSize - 1 ) {
				$conCur = 0;
			}
			$conTarget2.eq($conOld).stop().animate({ left : $conRange + '%' },400,$easing2);
			$conTarget2.eq($conCur).css({ left : (-1 * $conRange) + '%' }).stop().animate({ left : '0' },400,$easing1);
			$('.box_main_content_1 .ul_pos li').eq($conOld).removeClass('on');
			$('.box_main_content_1 .ul_pos li').eq($conCur).addClass('on');
		}
	}());
	// 뉴스보기
	var NEWS = (function(){
		var $btnPrev = $('.ul_nav_1 li.li_prev a'),
			$btnNext = $('.ul_nav_1 li.li_next a'),
			$cur = 0;
		// 총 뉴스 갯수
		$('.ul_news').each(function(){
			var $this = $(this),
				$size = $this.find('li').size(),
				$target = $this.siblings('.p_page_1').find('.total');
			$target.text($size);
		});
		// 이전 버튼
		$btnPrev.bind('click',function(){
			$(this).viewNews('left');
			return false;
		});
		// 다음 버튼
		$btnNext.bind('click',function(){
			$(this).viewNews('right');
			return false;
		});
		// 뉴스 보기
		$.fn.viewNews = function(direct){
			this.each(function(){
				var $this = $(this),
					$btnParent = $this.closest('ul'),
					$targetParent = $btnParent.siblings('.ul_news'),
					$target = $targetParent.find('li'),
					$curTxt = $btnParent.siblings('.p_page_1').find('.current'),
					$size = $target.size();
				switch (direct){
					case 'left':
						$cur--;
					break;
					case 'right':
						$cur++;
					break;
				}
				if ($cur < 0){
					$cur = $size - 1;
				} else if ($cur > $size -1 ){
					$cur = 0;
				}
				$curTxt.text($cur + 1);
				$target.removeClass('on');
				$target.eq($cur).addClass('on');
			})
		}
	}());
	// sns
	var SNS = (function(){
		var $btn = $('.box_sns h3 a'),
			$target = $('.box_sns > div');
		$btn.bind('click',function(){
			var $index = $(this).closest('div').index();
			viewSns($index);
			return false;
		});
		function viewSns(idx){
			if ($target.eq(idx).hasClass('on')){
				return false;
			} else {
				$target.removeClass('on');
				$target.eq(idx).addClass('on');
			}
		};
	}());
	// 팝업레이어
	var POPLAYER = (function(){
		var $target = $('.area_top_banner'),
			$img = $target.find('img'),
			$size = $img.width(),
			$close = $target.find('.btn_close a');
		$( window ).bind('resize',function(e){
			clearTimeout(resizeEvt);
			var resizeEvt = setTimeout(function() {
				$size = $img.width();
				$target.css({ marginLeft : -1 * $size/2 + 'px' });
			}, 50);
		});
		if ($(window).width() > 800 ){
			if ($('.area_top_banner')){
				$target.css({ marginLeft : -1 * $size/2 + 'px' });
			}
		}
		$close.bind('click',function(){
			$('.area_top_banner').remove();
		});
	}());
});