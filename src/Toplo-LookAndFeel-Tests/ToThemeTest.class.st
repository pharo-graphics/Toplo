"
A ToThemeTest is a test class for testing the behavior of ToTheme
"
Class {
	#name : #ToThemeTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-Tests-Theme'
}

{ #category : #tests }
ToThemeTest >> testDefaultToTheme [

	self assert: ToAbstractTheme current class equals: ToThemeLight
]

{ #category : #tests }
ToThemeTest >> testSkinForType [

	| theme |
	theme := ToAbstractTheme current.
	self assert: (theme class skinFor: ToButton type: #default) class equals: ToDefaultButtonSkin.
]

{ #category : #tests }
ToThemeTest >> testSkins [

	| theme skins |
	theme := ToAbstractTheme current.
	skins := theme skins.
	self assert: skins notEmpty.
	self assert: (skins first inheritsFrom: ToAbstractSkin).
]

{ #category : #tests }
ToThemeTest >> testThemeBeforeAddElement [

	| space button |
	space := BlSpace new.
	space toTheme: ToThemeDark new.
	
	button := ToButton skinType: #default.
	
	space root addChild: button.
	
	self assert: button toTheme equals: space toTheme.
]
