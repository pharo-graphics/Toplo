Class {
	#name : #ToGeneralButtonDresser,
	#superclass : #ToMouseHandlingDresser,
	#instVars : [
		'mouseUpOutsideHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'events handling' }
ToGeneralButtonDresser >> clicked: anElement [

	anElement dispatchEvent: ToClickLookEvent new.
	self hoveredState: anElement 

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

{ #category : #'events handling' }
ToGeneralButtonDresser >> hoveredState: anElement [

	self switchToState: ToHoveredState new in: anElement

]

{ #category : #'events handling' }
ToGeneralButtonDresser >> initialState: anElement [

	self switchToState: ToInitialState new in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	" since BlMousePickOutsideEvent is not a BlUIEvent, it is not handled by a BlEventListener"
	" and it should not because normally, a BlMousePickOutsideEvent is managed through a filter 
	to stop dispatching as soon as possible "
	mouseUpOutsideHandler := BlEventHandler
		                         on: BlMouseUpOutsideEvent
		                         do: [ :event | self mouseUpOutsideEvent: event in: anElement ].
	anElement addEventFilter: mouseUpOutsideHandler
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leaved: anElement [

	anElement dispatchEvent: ToLeavedLookEvent new
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

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftClickEvent: anEvent in: anElement [

	super leftClickEvent: anEvent in: anElement.
	self clicked: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftMouseDownEvent: anEvent in: anElement [

	super leftMouseDownEvent: anEvent in: anElement.
	self pressedState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftMouseUpEvent: anEvent in: anElement [

	super leftMouseUpEvent: anEvent in: anElement.
	self hoveredState: anElement 


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
	self hoveredState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> mouseLeaveEvent: anEvent in: anElement [

	super mouseLeaveEvent: anEvent in: anElement.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self leaved: anElement.
	self initialState: anElement



]

{ #category : #'events handling' }
ToGeneralButtonDresser >> mouseUpOutsideEvent: anEvent in: anElement [

	"Outside event can have a button element as target. 
	In that case, no action is triggered "
	anEvent consumed: true.
	(anEvent originalEvent target notNil and: [anEvent originalEvent target hasParent: anElement]) ifTrue: [
		^ self ].
	self initialState: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> pressedState: anElement [

	self switchToState: ToPressedState new in: anElement
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> switchToState: aState in: anElement [

	anElement switchToState: aState
]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventFilter: mouseUpOutsideHandler.
	super uninstallEventListenersIn: anElement.


]
