Class {
	#name : #ToGeneralButtonDresser,
	#superclass : #ToMouseHandlingDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'events handling' }
ToGeneralButtonDresser >> clickState: anElement [

	anElement dispatchEvent: ToClickLookEvent new


]

{ #category : #deprecated }
ToGeneralButtonDresser >> hover: anElement event: anEvent [

	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith: '`@receiver hover: `@anElement event: `@anEvent'
			-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
	super mouseEnterEvent: anEvent in: anElement.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self hoverState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> hoverState: anElement [

	anElement dispatchEvent: ToMouseHoverLookEvent new


]

{ #category : #'events handling' }
ToGeneralButtonDresser >> initialState: anElement [

	anElement dispatchEvent: ToInitialLookEvent new

]

{ #category : #deprecated }
ToGeneralButtonDresser >> leaved: anElement event: anEvent [

	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith: '`@receiver leaved: `@anElement event: `@anEvent'
			-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self leavedState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leavedState: anElement [

	anElement dispatchEvent: ToMouseLeavedLookEvent new


]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftClickEvent: anEvent in: anElement [

	super leftClickEvent: anEvent in: anElement.
	self clickState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftMouseDownEvent: anEvent in: anElement [

	super leftMouseDownEvent: anEvent in: anElement.
	self pressedState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftMouseUpEvent: anEvent in: anElement [

	super leftMouseUpEvent: anEvent in: anElement.
	self hoverState: anElement 


]

{ #category : #deprecated }
ToGeneralButtonDresser >> leftPressed: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver leftPressed: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseDownEvent: `@anEvent in: `@anElement'.

	self pressedState: anElement
]

{ #category : #deprecated }
ToGeneralButtonDresser >> leftUp: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseUpEvent:in: instead.'
		transformWith: '`@receiver leftUp: `@anElement event: `@anEvent'
			-> '`@receiver leftMouseUpEvent: `@anEvent in: `@anElement'.

	self leftMouseUpEvent: anEvent in: anElement.

]

{ #category : #'events handling' }
ToGeneralButtonDresser >> mouseEnterEvent: anEvent in: anElement [

	super mouseEnterEvent: anEvent in: anElement.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self hoverState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> mouseLeaveEvent: anEvent in: anElement [

	super mouseLeaveEvent: anEvent in: anElement.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self leavedState: anElement



]

{ #category : #'events handling' }
ToGeneralButtonDresser >> mouseUpOutside: anElement event: anEvent [

	super mouseUpOutside: anElement event: anEvent.
	self initialState: anElement

]

{ #category : #'events handling' }
ToGeneralButtonDresser >> pressedState: anElement [

	anElement dispatchEvent: ToMousePressedLookEvent new
]
