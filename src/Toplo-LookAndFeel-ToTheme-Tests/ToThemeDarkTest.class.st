"
A ToThemeDarkTest is a test class for testing the behavior of ToThemeDark
"
Class {
	#name : #ToThemeDarkTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Themes'
}

{ #category : #tests }
ToThemeDarkTest >> testIsDark [

	self assert: ToThemeDark new isDark
]

{ #category : #tests }
ToThemeDarkTest >> testIsLight [

	self assert: ToThemeDark new isLight not
]
