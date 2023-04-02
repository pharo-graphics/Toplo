"
A ToThemeTest is a test class for testing the behavior of ToTheme
"
Class {
	#name : #ToThemeTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Themes'
}

{ #category : #tests }
ToThemeTest >> testDefaultToTheme [

	self assert: ToAbstractTheme current class equals: ToThemeLight
]
