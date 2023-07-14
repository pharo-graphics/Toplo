Class {
	#name : #ToMouseHandlingDresser,
	#superclass : #ToDresser,
	#instVars : [
		'mouseEventListener'
	],
	#category : #'Toplo-Core'
}

{ #category : #private }
ToMouseHandlingDresser >> background: aBackground in: anElement [

	anElement
		disableEventType: BlElementBackgroundChangedEvent 
		while: [ anElement background: aBackground ]
]

{ #category : #private }
ToMouseHandlingDresser >> border: aBorder in: anElement [

	anElement
		disableEventType: BlElementBorderChangedEvent
		while: [ anElement border: aBorder ]
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> clickEvent: anEvent in: anElement [

	^ anEvent
		  ifPrimary: [ self leftClickEvent: anEvent in: anElement ]
		  secondary: [ self rightClickEvent: anEvent in: anElement ]
		  middle: [ self middleClickEvent: anEvent in: anElement ]
		  other: [ self leftClickEvent: anEvent in: anElement ]
]

{ #category : #deprecated }
ToMouseHandlingDresser >> clicked: anElement event: anEvent [


	self
		deprecated: 'Please use clickEvent:in: instead.'
		transformWith:
			'`@receiver clicked: `@anElement event: `@anEvent'
				-> '`@receiver clickEvent: `@anEvent in: `@anElement'.

	^ self  clickEvent: anEvent in: anElement
]

{ #category : #deprecated }
ToMouseHandlingDresser >> clickedAvorted: anElement event: anEvent [

	" if mouse up is on anElement or on in one of anElement children then it means that a click is done "
	self
		deprecated: 'Please use clickedAvortedEvent:in: instead.'
		transformWith:
			'`@receiver clickedAvorted: `@anElement event: `@anEvent'
				-> '`@receiver clickedAvortedEvent: `@anEvent in: `@anElement'.

	(anEvent upTarget ~= anElement and: [ (anElement findMouseEventTargetAt: anEvent upTarget position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> clickedAvortedEvent: anEvent in: anElement [

	" if mouse up is on anElement or on in one of anElement children then it means that a click is done "

	(anEvent upTarget ~= anElement and: [ (anElement findMouseEventTargetAt: anEvent upTarget position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> doubleClickEvent: anEvent in: anElement [


]

{ #category : #deprecated }
ToMouseHandlingDresser >> doubleClicked: anElement event: anEvent [

	self
		deprecated: 'Please use clickedAvortedEvent:in: instead.'
		transformWith:
			'`@receiver doubleClicked: `@anElement event: `@anEvent'
				-> '`@receiver doubleClickedEvent: `@anEvent in: `@anElement'.
]

{ #category : #deprecated }
ToMouseHandlingDresser >> hover: anElement event: anEvent [

	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith:
			'`@receiver hover: `@anElement event: `@anEvent'
				-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
]

{ #category : #'api - install/uninstall  hook' }
ToMouseHandlingDresser >> initialState: anElement [
]

{ #category : #'api - install/uninstall  hook' }
ToMouseHandlingDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	
	mouseEventListener := ToDresserMouseEventListener new target: anElement; dresser: self; yourself.
	anElement addEventHandler: mouseEventListener

]

{ #category : #deprecated }
ToMouseHandlingDresser >> leaved: anElement event: anEvent [
	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith:
			'`@receiver leaved: `@anElement event: `@anEvent'
				-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> leftClickEvent: anEvent in: anElement [

]

{ #category : #deprecated }
ToMouseHandlingDresser >> leftClicked: anElement event: anEvent [

	self
		deprecated: 'Please use leftClickEvent:in: instead.'
		transformWith:
			'`@receiver leftClicked: `@anElement event: `@anEvent'
				-> '`@receiver leftClickEvent: `@anEvent in: `@anElement'.
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> leftMouseDownEvent: anEvent in: anElement [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> leftMouseUpEvent: anEvent in: anElement [

]

{ #category : #deprecated }
ToMouseHandlingDresser >> leftPressed: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver leftPressed: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseDownEvent: `@anEvent in: `@anElement'.
]

{ #category : #deprecated }
ToMouseHandlingDresser >> leftUp: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseUpEvent:in: instead.'
		transformWith:
			'`@receiver leftUp: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseUpEvent: `@anEvent in: `@anElement'.

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> middleClickEvent: anEvent in: anElement [


]

{ #category : #deprecated }
ToMouseHandlingDresser >> middleClicked: anElement event: anEvent [

	self
		deprecated: 'Please use middleClickEvent:in: instead.'
		transformWith:
			'`@receiver middleClicked: `@anElement event: `@anEvent'
				-> '`@receiver middleClickEvent: `@anEvent in: `@anElement'.
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> middleMouseDownEvent: anEvent in: anElement [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> middleMouseUpEvent: anEvent in: anElement [

]

{ #category : #deprecated }
ToMouseHandlingDresser >> middlePressed: anElement event: anEvent [

	self
		deprecated: 'Please use middleMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver middlePressed: `@anElement event: `@anEvent'
				-> '`@receiver middleMouseDownEvent: `@anEvent in: `@anElement'.

]

{ #category : #deprecated }
ToMouseHandlingDresser >> middleUp: anElement event: anEvent [

	self
		deprecated: 'Please use middleMouseUpEvent:in: instead.'
		transformWith:
			'`@receiver middleUp: `@anElement event: `@anEvent'
				-> '`@receiver middleMouseUpEvent: `@anEvent in: `@anElement'.

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> mouseDownEvent: anEvent in: anElement [

	^ anEvent
		  ifPrimary: [ self leftMouseDownEvent: anEvent in: anElement ]
		  secondary: [ self rightMouseDownEvent: anEvent in: anElement ]
		  middle: [ self middleMouseDownEvent: anEvent in: anElement ]
		  other: [ self leftMouseDownEvent: anEvent in: anElement ]
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> mouseDownOutside: anElement event: anEvent [

	
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> mouseEnterEvent: anEvent in: anElement [
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> mouseLeaveEvent: anEvent in: anElement [

	
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> mousePickOutsideEvent: anEvent in: anElement [

	
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> mouseUpEvent: anEvent in: anElement [

	^ anEvent
		  ifPrimary: [ self leftMouseUpEvent: anEvent in: anElement ]
		  secondary: [ self rightMouseUpEvent: anEvent in: anElement ]
		  middle: [ self middleMouseUpEvent: anEvent in: anElement ]
		  other: [ self leftMouseUpEvent: anEvent in: anElement ]
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> mouseUpOutside: anElement event: anEvent [

	
]

{ #category : #'api - install/uninstall  hook' }
ToMouseHandlingDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement
]

{ #category : #deprecated }
ToMouseHandlingDresser >> pressed: anElement event: anEvent [

	self
		deprecated: 'Please use mouseDownEvent:in: instead.'
		transformWith:
			'`@receiver pressed: `@anElement event: `@anEvent'
				-> '`@receiver mouseDownEvent: `@anEvent in: `@anElement'.

	^ anEvent
		  ifPrimary: [ self leftPressed: anElement event: anEvent ]
		  secondary: [ self rightPressed: anElement event: anEvent ]
		  middle: [ self middlePressed: anElement event: anEvent ]
		  other: [ self leftPressed: anElement event: anEvent ]
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> rightClickEvent: anEvent in: anElement [
]

{ #category : #deprecated }
ToMouseHandlingDresser >> rightClicked: anElement event: anEvent [

	self
		deprecated: 'Please use rightClickEvent:in: instead.'
		transformWith:
			'`@receiver rightClicked: `@anElement event: `@anEvent'
				-> '`@receiver rightClickEvent: `@anEvent in: `@anElement'.
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> rightMouseDownEvent: anEvent in: anElement [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> rightMouseUpEvent: anEvent in: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToMouseHandlingDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: mouseEventListener.
	super uninstallEventListenersIn: anElement.

]
