Class {
	#name : 'ToThemeVariant',
	#superclass : 'Object',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'space configurating' }
ToThemeVariant >> changedTokenProperties [

	^ {  }
]

{ #category : 'api - hooks' }
ToThemeVariant >> onInstalledIn: aSpace [

	aSpace root addAllTokenProperties: self changedTokenProperties
]
