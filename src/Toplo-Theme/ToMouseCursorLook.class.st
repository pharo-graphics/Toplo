Class {
	#name : #ToMouseCursorLook,
	#superclass : #ToMultiStateLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToMouseCursorLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #private }
ToMouseCursorLook >> apply: aStateValue on: anElement [

	anElement mouseCursor: (aStateValue valueIn: anElement)
]

{ #category : #initialization }
ToMouseCursorLook >> defaultInitialValue [

	^ nil asStateValue
]
