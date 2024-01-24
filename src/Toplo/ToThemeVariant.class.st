Class {
	#name : #ToThemeVariant,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'space configurating' }
ToThemeVariant class >> changedTokenProperties [

	^ {  }
]

{ #category : #'space configurating' }
ToThemeVariant >> changedTokenProperties [

	^ self class changedTokenProperties
]

{ #category : #'api - hooks' }
ToThemeVariant >> onInstalledIn: anElement [

	anElement addAllTokenProperties: self changedTokenProperties
]

{ #category : #'api - hooks' }
ToThemeVariant >> onUninstalledIn: anElement [

	anElement removeAllTokenPropertiesFromNames: (self changedTokenProperties collect: [:tp | tp name]).

]
