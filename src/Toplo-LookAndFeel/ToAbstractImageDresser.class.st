Class {
	#name : #ToAbstractImageDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #testing }
ToAbstractImageDresser class >> isAbstract [

	^ self == ToAbstractImageDresser
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractImageDresser >> foreground: aBlPaint in: aToImage [

	|background form|
	aToImage innerImage ifNil: [ ^self ].
	background := aToImage innerImage background ifNil: [ ^self ].
	(background isKindOf: BlImageBackground) ifFalse: [ ^self ].
	form := background image ifNil: [ ^self ].
	
	form := form collectColors: [ :color | aBlPaint alpha: color alpha].
	aToImage innerImage: form

	
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractImageDresser >> initialState: aToImage [

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractImageDresser >> onInstalledIn: aToImage [

	super onInstalledIn: aToImage.
	self initialState: aToImage
]
