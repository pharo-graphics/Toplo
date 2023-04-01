"
A ToThemeLightTest is a test class for testing the behavior of ToThemeLight
"
Class {
	#name : #ToThemeLightTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Themes'
}

{ #category : #tests }
ToThemeLightTest >> testIsDark [

	self assert: ToThemeLight new isDark not
]

{ #category : #tests }
ToThemeLightTest >> testIsLight [

	self assert: ToThemeLight new isLight
]
