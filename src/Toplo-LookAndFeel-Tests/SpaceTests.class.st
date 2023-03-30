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
SpaceTests >> testDefaultSpaceTheme [

	| space |
	space := OBlSpace new.
	self assert: space toTheme class equals: ToTheme default class.
	
]
