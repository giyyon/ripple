/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	

	config.enterMode =CKEDITOR.ENTER_BR;		//엔터키 입력시 br 태그 변경
	
    config.basicEntities = false;
    config.entities = false;
    config.entities_latin = false;
    config.entities_greek = false;
    config.entities_processNumerical = false;
	
	
	config.extraPlugins = 'autogrow';
	config.autoGrow_minHeight = 200;
	config.autoGrow_maxHeight = 600;
	config.autoGrow_bottomSpace = 30;
	

	
};
