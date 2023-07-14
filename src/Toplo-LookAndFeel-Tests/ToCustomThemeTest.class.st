"
This class contains tests for custom Theme (writed by another team that Toplo) and to test features which a not included in the ToTheme.
"
Class {
	#name : #ToCustomThemeTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-Tests-Theme'
}

{ #category : #tests }
ToCustomThemeTest >> testChangeSpaceTheme [
	| button space |

	button := ToButton skinType: #default.
	space := BlSpace new.
	space root addChild: button.
	
	space toTheme: ToThemeDark new.
	self assert: space toTheme class equals: ToThemeDark.
	self assert: button toTheme class equals: ToThemeDark.
	
	space toTheme: ToCustomNoDarkNoLightTestTheme new.
	self assert: space toTheme class equals: ToCustomNoDarkNoLightTestTheme.
	self assert: button toTheme class equals: ToCustomNoDarkNoLightTestTheme.
	
	"test button skin tokens"
	self assert: (button skin token: #background) equals: nil.
]

{ #category : #tests }
ToCustomThemeTest >> testChangeThemeAddChildInAParentInASpace [

	| space button pane |
	space := BlSpace new.
	space toTheme: ToCustomNoDarkNoLightTestTheme new.

	pane := ToPane horizontal.
	button := ToButton skinType: #default.
	pane addChild: button.
	
	space root addChild: pane.
	
	self assert: button toTheme equals: space toTheme.
	self assert: button skin class equals: ToEmptyTestSkin.
]

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
ToCustomThemeTest >> testNoDarkAndNoLightTheme [
	"Test for Theme which are not supported light/dark mode, just one usage"
	
	| theme |
	theme := ToCustomNoDarkNoLightTestTheme new.
	self assert: theme isSupportLightAndDark equals: false.
	self assert: theme isLight equals: false.
	self assert: theme isDark equals: false.
	self assert: theme darkTheme isNil.
	self assert: theme lightTheme isNil.
]

{ #category : #tests }
ToCustomThemeTest >> testOtherThemeThanDefaultBeforeAddElement [

	| space button |
	space := BlSpace new.
	space toTheme: ToCustomNoDarkNoLightTestTheme new.
	
	button := ToButton skinType: #default.
	self assert: button skin class equals: ToDefaultButtonSkin.
	
	space root addChild: button.
	
	self assert: button toTheme equals: space toTheme.
	self assert: button skin class equals: ToEmptyTestSkin.
]

{ #category : #tests }
ToCustomThemeTest >> testSkinForType [

	| theme |
	theme := ToCustomNoDarkNoLightTestTheme new.
	self assert: (theme class skinFor: ToButton type: #default) class equals: ToEmptyTestSkin.
	
	theme := ToCustomTest2Theme new.
	self assert: (theme class skinFor: ToButton type: #default) class equals: ToButtonTestSkin.
]
