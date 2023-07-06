Class {
	#name : #ToGeneralButtonDresser,
	#superclass : #ToMouseHandlingDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'events handling' }
ToGeneralButtonDresser >> hover: anElement event: anEvent [

	super hover: anElement event: anEvent.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self hoverState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> hoverState: anElement [

	anElement dispatchEvent: ToHoverLookEvent new


]

{ #category : #'events handling' }
ToGeneralButtonDresser >> initialState: anElement [

	anElement dispatchEvent: ToInitialLookEvent new

]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leaved: anElement event: anEvent [

	super leaved: anElement event: anEvent.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self initialState: anElement



]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftPressed: anElement event: anEvent [

	self pressedState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftUp: anElement event: anEvent [

	super leftUp: anElement event: anEvent.
	self hoverState: anElement 


]

{ #category : #'events handling' }
ToGeneralButtonDresser >> pressedState: anElement [

	anElement dispatchEvent: ToPressedLookEvent new
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> upOutside: anElement event: anEvent [

	super upOutside: anElement event: anEvent.
	self initialState: anElement

]
