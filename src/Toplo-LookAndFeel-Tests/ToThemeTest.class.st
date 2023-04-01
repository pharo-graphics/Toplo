"
A ToThemeTest is a test class for testing the behavior of ToTheme
"
Class {
	#name : #ToThemeTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Theme'
}

{ #category : #tests }
ToThemeTest >> testDefaultToTheme [

	self assert: ToTheme default class equals: ToThemeLight
]
