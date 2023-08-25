Class {
	#name : #ToGeneralButtonDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToGeneralButtonDresser class >> isDeprecated [ 

	^ true
]

{ #category : #deprecated }
ToGeneralButtonDresser >> hover: anElement event: anEvent [

	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith: '`@receiver hover: `@anElement event: `@anEvent'
			-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
	super mouseEnterEvent: anEvent in: anElement.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self hoveredState: anElement
]

{ #category : #deprecated }
ToGeneralButtonDresser >> leaved: anElement event: anEvent [

	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith: '`@receiver leaved: `@anElement event: `@anEvent'
			-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self leaved: anElement
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
