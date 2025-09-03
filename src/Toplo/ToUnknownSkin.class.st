Class {
	#name : #ToUnknownSkin,
	#superclass : #ToSkin,
	#classVars : [
		'Instance'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #accessing }
ToUnknownSkin class >> instance [ 

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : #adding }
ToUnknownSkin >> addSkinStateGeneration: aValuable for: anElement [

	" in case the element is not is space, its skin state can be updated  "
	aValuable value
]

{ #category : #testing }
ToUnknownSkin >> isUnknownSkin [ 

	^ true
]
