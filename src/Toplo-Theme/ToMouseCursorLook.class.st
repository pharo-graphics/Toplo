Class {
	#name : #ToMouseCursorLook,
	#superclass : #ToMultiStateLook,
	#category : #'Toplo-Theme-Look-Dep'
}

{ #category : #testing }
ToMouseCursorLook class >> isDeprecated [ 

	^ true
]

{ #category : #private }
ToMouseCursorLook >> apply: aStateValue on: anElement [

	anElement mouseCursor: (aStateValue valueIn: anElement)
]
