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

{ #category : #testing }
ToUnknownSkin >> isUnknownSkin [ 

	^ true
]
