/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	config.language = 'ko';
	// config.uiColor = '#AADC6E';
	
	

//	config.enterMode =CKEDITOR.ENTER_BR;		//엔터키 입력시 br 태그 변경
	
    config.basicEntities = false;
    config.entities = false;
    config.entities_latin = false;
    config.entities_greek = false;
    config.entities_processNumerical = false;
	
	
	config.toolbar = 'Full';

	config.toolbar_Full =
	[
	    ['Source','-','NewPage','Preview'],
	    ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print'],
	    ['Undo','Redo','-','Find','Replace','-','RemoveFormat'],
//	    ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
	    ['Link','Unlink'],
	    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	    
	    '/',
	    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],	    
	    ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
	    '/',
	    ['Styles','Format','Font','FontSize'],
	    ['TextColor','BGColor'],
	    ['Maximize', 'ShowBlocks','-','About']
	];
	
};
