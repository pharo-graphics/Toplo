Class {
	#name : #ToDefaultThemeLight,
	#superclass : #ToDefaultTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #colors }
ToDefaultThemeLight >> darkTheme [

	^ self class colorPrimaryDark: self colorPrimary
]

{ #category : #initialization }
ToDefaultThemeLight >> initialize [ 

	super initialize.
	self name: 'Toplo Light'
]

{ #category : #colors }
ToDefaultThemeLight >> isDark [

	^ false
]

{ #category : #colors }
ToDefaultThemeLight >> isLight [

	^ true
]

{ #category : #colors }
ToDefaultThemeLight >> lightTheme [

	^ self
]
