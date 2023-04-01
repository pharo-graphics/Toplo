"
A ToThemeLightTest is a test class for testing the behavior of ToThemeLight
"
Class {
	#name : #ToThemeLightTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Themes'
}

{ #category : #tests }
ToThemeLightTest >> testDarkTheme [

	self assert: ToThemeLight new darkTheme class equals: ToThemeDark
]

{ #category : #tests }
ToThemeLightTest >> testIsDark [

	self assert: ToThemeLight new isDark not
]

{ #category : #tests }
ToThemeLightTest >> testIsLight [

	self assert: ToThemeLight new isLight
]

{ #category : #tests }
ToThemeLightTest >> testLightTheme [

	self assert: ToThemeLight new lightTheme class equals: ToThemeLight
]
