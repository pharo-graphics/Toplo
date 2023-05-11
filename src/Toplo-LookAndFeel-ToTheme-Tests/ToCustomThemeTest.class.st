"
This class contains tests for custom Theme (writed by another team that Toplo) and to test features which a not included in the ToTheme.
"
Class {
	#name : #ToCustomThemeTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Themes'
}

{ #category : #tests }
ToCustomThemeTest >> testDefaultButtonSkin [
	"Test when a Theme can not provide a #default type skin for a Widget, in this case a skin is return as a default, this should be the first skin of the supported widget skin list"
	
	| skin skinClassListForButton |
	skin := ToCustomNoDarkNoLightTestTheme skinFor: ToButton type: #default.
	"This Theme have no default skin for button, but the returned skin should be the first"
	skinClassListForButton := ToCustomNoDarkNoLightTestTheme skinClassesFor: ToButton.
	self assert: skin class equals: skinClassListForButton first.
	self assert: skin class equals: ToEmptyTestSkin.
	"And the returned skin is not #default type, in case of not supported skin type by the theme"
	self assert: ToEmptyTestSkin type equals: #empty.
	
	"No skin for this widget"
	skin := ToCustomNoDarkNoLightTestTheme skinFor: ToLabel type: #default.
	self assert: skin isNil.
]

{ #category : #tests }
ToCustomThemeTest >> testDefaultLabelSkin [
	"Test when a Theme can not provide a skin for a widget"
	
	| skin |
	"No skin for this widget"
	skin := ToCustomNoDarkNoLightTestTheme skinFor: ToLabel type: #default.
	self assert: skin isNil.
]

{ #category : #tests }
ToCustomThemeTest >> testOtherThemeThanDefaultBeforeAddElement [

	| space button |
	space := OBlSpace new.
	space toTheme: ToCustomNoDarkNoLightTestTheme new.
	
	button := ToButton skinType: #default.
	self assert: button skin class equals: ToDefaultButtonSkin.
	
	space root addChild: button.
	
	self assert: button toTheme equals: space toTheme.
	self assert: button skin class equals: ToEmptyTestSkin.
]
