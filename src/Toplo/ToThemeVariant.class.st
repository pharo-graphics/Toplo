Class {
	#name : 'ToThemeVariant',
	#superclass : 'Object',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'space configurating' }
ToThemeVariant class >> changedTokenProperties [

	^ {  }
]

{ #category : 'space configurating' }
ToThemeVariant >> changedTokenProperties [

	^ self class changedTokenProperties
]

{ #category : 'api - hooks' }
ToThemeVariant >> onInstalledIn: aSpace [

	aSpace root addAllTokenProperties: self changedTokenProperties
]
