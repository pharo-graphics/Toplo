Class {
	#name : #ToImageLook,
	#superclass : #ToMultiStateLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #private }
ToImageLook >> apply: aStateValue on: anElement [

	anElement innerImage: (aStateValue valueIn: anElement) 
]

{ #category : #initialization }
ToImageLook >> defaultInitialValue [

	^ nil asStateValue
]
