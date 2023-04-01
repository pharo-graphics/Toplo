"
A ToLAFButtonDresserTest is a test class for testing the behavior of ToLAFButtonDresser
"
Class {
	#name : #ToElementsTests,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Extensions Tests'
}

{ #category : #tests }
ToElementsTests >> testChangeSkin [

	| element |
	element := ToElement new.
	element skin: ToPrimaryButtonSkin new.
	
	self assert: element skin class equals: ToPrimaryButtonSkin.
	
	element skin: ToDefaultButtonSkin new.
	
	self assert: element skin class equals: ToDefaultButtonSkin.
		 
]

{ #category : #tests }
ToElementsTests >> testChangeTheme [

	| element |
	element := ToElement new.
	element toTheme: ToThemeDark new.
	
	self assert: element toTheme class equals: ToThemeDark.
	
	element toTheme: ToThemeLight new.
	
	self assert: element toTheme class equals: ToThemeLight.
]

{ #category : #tests }
ToElementsTests >> testDefaultSkin [

	| element |
	element := ToElement new.
	
	self assert: element skin isNil
]

{ #category : #tests }
ToElementsTests >> testDefaultTheme [

	| element |
	element := ToElement new.
	
	self assert: element toTheme class equals: ToAbstractTheme current class.
]
