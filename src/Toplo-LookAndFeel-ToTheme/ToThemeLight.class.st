Class {
	#name : #ToThemeLight,
	#superclass : #ToTheme,
	#category : #'Toplo-LookAndFeel-ToTheme-Themes'
}

{ #category : #initialization }
ToThemeLight >> initialize [ 

	super initialize.
	self name: 'Toplo light Theme'
]

{ #category : #colors }
ToThemeLight >> isDark [

	^ false
]

{ #category : #colors }
ToThemeLight >> isLight [

	^ true
]
