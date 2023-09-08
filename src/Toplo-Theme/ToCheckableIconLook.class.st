Class {
	#name : #ToCheckableIconLook,
	#superclass : #ToMultiStateLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #testing }
ToCheckableIconLook class >> isDeprecated [ 

	^ true
]

{ #category : #private }
ToCheckableIconLook >> apply: aStateValue on: anElement [

	| im |
	im := aStateValue valueIn: anElement.
	im ifNil: [ ^ self ].
	anElement icon ifNotNil: [ :ic |
		ic innerImage = im ifTrue: [ ^ self ].
		ic innerImage removeFromParent ].
	anElement icon: (ToImage inner: im)
]
