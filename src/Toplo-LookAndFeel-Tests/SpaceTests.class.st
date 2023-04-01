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
	self assert: (button skin tokens at: #background) equals: (ToClearTheme new colorBgContainer).
	
	space := OBlSpace new.
	space addChild: button.
	
	space toTheme: ToDarkTheme new.
	self assert: space toTheme class equals: ToDarkTheme.
	self assert: button toTheme class equals: ToDarkTheme.
	
	"test button skin tokens"
	self assert: (button skin tokens at: #background) equals: (ToDarkTheme new colorBgContainer).
]

{ #category : #tests }
SpaceTests >> testChangeSpaceThemeAndDontTouchSpecifiedElementTheme [

	| button1 space button2 |
	button1 := self createDefaultButton.
	"force a theme on a Space branch, here we want always a clear theme button"
	button1 toTheme: ToClearTheme new.

	button2 := self createDefaultButton.
	
	space := OBlSpace new.
	space addChild: button1.
	space addChild: button2.
	
	"change the general theme"
	space toTheme: ToDarkTheme new.
	
	self assert: space toTheme class equals: ToDarkTheme.
	self assert: button1 toTheme class equals: ToClearTheme.
	self assert: button2 toTheme class equals: ToDarkTheme.
	
	"test skin token"
	self assert: (button1 skin tokens at: #background) equals: (ToClearTheme new colorBgContainer).
	self assert: (button2 skin tokens at: #background) equals: (ToDarkTheme new colorBgContainer).
]

{ #category : #tests }
SpaceTests >> testDefaultSpaceTheme [

	| space |
	space := OBlSpace new.
	self assert: space toTheme class equals: ToTheme default class.
	
]
