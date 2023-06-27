"
A ToThemeDarkTest is a test class for testing the behavior of ToThemeDark
"
Class {
	#name : #ToThemeDarkTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-Tests-Theme'
}

{ #category : #tests }
ToThemeDarkTest >> testDarkTheme [

	self assert: ToThemeDark new darkTheme class equals: ToThemeDark
]

{ #category : #tests }
ToThemeDarkTest >> testIsDark [

	self assert: ToThemeDark new isDark
]

{ #category : #tests }
ToThemeDarkTest >> testIsLight [

	self assert: ToThemeDark new isLight not
]

{ #category : #tests }
ToThemeDarkTest >> testLightTheme [

	self assert: ToThemeDark new lightTheme class equals: ToThemeLight
]
