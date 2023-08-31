Class {
	#name : #ToThemeLight,
	#superclass : #ToTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #colors }
ToThemeLight >> darkTheme [

	^ self class colorPrimaryDark: self colorPrimary
]

{ #category : #initialization }
ToThemeLight >> initialize [ 

	super initialize.
	self name: 'Toplo Light'
]

{ #category : #colors }
ToThemeLight >> isDark [

	^ false
]

{ #category : #colors }
ToThemeLight >> isLight [

	^ true
]

{ #category : #colors }
ToThemeLight >> lightTheme [

	^ self
]
