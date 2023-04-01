Class {
	#name : #SpaceTests,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Tests'
}

{ #category : #private }
SpaceTests >> createDefaultButton [

	| button |
	button := ToButton new.
	button dresser: ToLAFButtonDresser new.
	^ button
]

{ #category : #tests }
SpaceTests >> testChangeSpaceTheme [

	| button space |
	button := self createDefaultButton.
	"test button skin tokens"
	self assert: (button skin tokens at: #background) equals: (ToThemeLight new colorBgContainer).
	
	space := OBlSpace new.
	space addChild: button.
	
	space toTheme: ToThemeDark new.
	self assert: space toTheme class equals: ToThemeDark.
	self assert: button toTheme class equals: ToThemeDark.
	
	"test button skin tokens"
	self assert: (button skin tokens at: #background) equals: (ToThemeDark new colorBgContainer).
]

{ #category : #tests }
SpaceTests >> testChangeSpaceThemeAndDontTouchSpecifiedElementTheme [

	| button1 space button2 |
	button1 := self createDefaultButton.
	"force a theme on a Space branch, here we want always a clear theme button"
	button1 toTheme: ToThemeLight new.

	button2 := self createDefaultButton.
	
	space := OBlSpace new.
	space addChild: button1.
	space addChild: button2.
	
	"change the general theme"
	space toTheme: ToThemeDark new.
	
	self assert: space toTheme class equals: ToThemeDark.
	self assert: button1 toTheme class equals: ToThemeLight.
	self assert: button2 toTheme class equals: ToThemeDark.
	
	"test skin token"
	self assert: (button1 skin tokens at: #background) equals: (ToThemeLight new colorBgContainer).
	self assert: (button2 skin tokens at: #background) equals: (ToThemeDark new colorBgContainer).
]

{ #category : #tests }
SpaceTests >> testDefaultSpaceTheme [

	| space |
	space := OBlSpace new.
	self assert: space toTheme class equals: ToTheme default class.
	
]
