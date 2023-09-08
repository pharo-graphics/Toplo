Class {
	#name : #ToCheckLook,
	#superclass : #ToMultiStateLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #private }
ToCheckLook >> apply: aStateValue on: anElement [

	| im |
	im := (aStateValue valueIn: anElement).
	im ifNil: [ ^ self ].
	anElement icon ifNotNil: [ :ic | ic innerImage = im ifTrue: [ ^ self ] ].
	anElement iconImage: im
]

{ #category : #initialization }
ToCheckLook >> defaultInitialValue [

	^ (BlElement new size: 16 asPoint; yourself) asStateValue 
]
