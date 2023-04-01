Class {
	#name : #ToLightTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-LookAndFeel-Theme'
}

{ #category : #initialization }
ToLightTheme >> initialize [ 

	super initialize.
	self name: 'Toplo light Theme'
]

{ #category : #colors }
ToLightTheme >> isDark [

	^ false
]

{ #category : #colors }
ToLightTheme >> isLight [

	^ true
]
