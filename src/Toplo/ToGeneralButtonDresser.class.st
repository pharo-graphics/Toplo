Class {
	#name : #ToGeneralButtonDresser,
	#superclass : #ToMouseHandlingDresser,
	#instVars : [
		'mouseUpOutsideHandler',
		'lastLookEvent'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'events handling' }
ToGeneralButtonDresser >> clickState: anElement [

	anElement dispatchEvent: ToClickLookEvent new
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> dispatchEvent: aLookEvent to: anElement [

	anElement dispatchEvent: aLookEvent.
	lastLookEvent := aLookEvent


]

{ #category : #deprecated }
ToGeneralButtonDresser >> hover: anElement event: anEvent [

	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith:
			'`@receiver hover: `@anElement event: `@anEvent'
				-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
	super hover: anElement event: anEvent.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self hoverState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> hoverState: anElement [

	self switchToLook: ToMouseHoverLookEvent in: anElement

]

{ #category : #'events handling' }
ToGeneralButtonDresser >> initialState: anElement [

	self switchToLook: ToInitialLookEvent in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	" since BlMousePickOutsideEvent is not a BlUIEvent, it is not handled by a BlEventListener"
	" and it should not because normally, a BlMousePickOutsideEvent is managed through a filter "
	mouseUpOutsideHandler := BlEventHandler
		                         on: BlMouseUpOutsideEvent
		                         do: [ :event | self mouseUpOutsideEvent: event in: anElement ].
	anElement addEventFilter: mouseUpOutsideHandler
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
	self leavedState: anElement.
	self initialState: anElement



]

{ #category : #'events handling' }
ToGeneralButtonDresser >> mouseUpOutsideEvent: anEvent in: anElement [

	"Outside event can have a button element as target. 
	In that case, no action is triggered "
	anEvent consumed: true.
	(anEvent originalEvent target hasParent: anElement) ifTrue: [
		^ self ].
	self initialState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> pressedState: anElement [

	self switchToLook: ToMousePressedLookEvent in: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> switchToLook: aLookEventClass in: anElement [

	lastLookEvent class = aLookEventClass ifTrue: [ ^ self ].
	aLookEventClass traceCr.
	self dispatchEvent: aLookEventClass new to: anElement


]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventFilter: mouseUpOutsideHandler.
	super uninstallEventListenersIn: anElement.


]
