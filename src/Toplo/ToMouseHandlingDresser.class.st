Class {
	#name : #ToMouseHandlingDresser,
	#superclass : #ToDresser,
	#instVars : [
		'mouseDownHandler',
		'mouseEnterHandler',
		'mouseLeaveHandler',
		'mouseClickHandler',
		'mouseDoubleClickHandler',
		'mouseUpHandler'
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
ToMouseHandlingDresser >> clicked: anElement event: anEvent [

	^ anEvent
		  ifPrimary: [ self leftClicked: anElement event: anEvent ]
		  secondary: [ self rightClicked: anElement event: anEvent ]
		  middle: [ self middleClicked: anElement event: anEvent ]
		  other: [ self leftClicked: anElement event: anEvent ]
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> doubleClicked: anElement event: anEvent [


]

{ #category : #'events handling' }
ToMouseHandlingDresser >> hover: anElement event: anEvent [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> initialState: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToMouseHandlingDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	mouseDownHandler := self mouseDownHandlerIn: anElement.
	mouseUpHandler := self mouseUpHandlerIn: anElement.
	mouseClickHandler := self mouseClickHandlerIn: anElement.
	mouseDoubleClickHandler := self mouseDoubleClickHandlerIn: anElement.
	mouseEnterHandler := self mouseEnterHandlerIn: anElement.
	mouseLeaveHandler := self mouseLeaveHandlerIn: anElement.
	
	anElement addEventHandler: mouseDownHandler.
	anElement addEventHandler: mouseUpHandler.
	anElement addEventHandler: mouseClickHandler.
	anElement addEventHandler: mouseDoubleClickHandler.
	anElement addEventHandler: mouseEnterHandler.
	anElement addEventHandler: mouseLeaveHandler.

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> leaved: anElement event: anEvent [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> leftClicked: anElement event: anEvent [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> leftPressed: anElement event: anEvent [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> leftUp: anElement event: anEvent [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> middleClicked: anElement event: anEvent [
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> middlePressed: anElement event: anEvent [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> middleUp: anElement event: anEvent [

]

{ #category : #'event handlers' }
ToMouseHandlingDresser >> mouseClickHandlerIn: anElement [

	^ BlEventHandler
		  on: BlClickEvent
		  do: [ :event | self clicked: anElement event: event ]
]

{ #category : #'event handlers' }
ToMouseHandlingDresser >> mouseDoubleClickHandlerIn: anElement [

	^ BlEventHandler
		  on: BlDoubleClickEvent
		  do: [ :event | self doubleClicked: anElement event: event ]
]

{ #category : #'event handlers' }
ToMouseHandlingDresser >> mouseDownHandlerIn: anElement [

	^ BlEventHandler
		  on: BlMouseDownEvent
		  do: [ :event | self pressed: anElement event: event ]
]

{ #category : #'event handlers' }
ToMouseHandlingDresser >> mouseEnterHandlerIn: anElement [

	^ BlEventHandler on: BlMouseEnterEvent 
		do: [ :event | 
			(event anyButtonPressed and: [event currentTarget ~= anElement ] )
				ifFalse: [self hover: anElement event: event] ]
]

{ #category : #'event handlers' }
ToMouseHandlingDresser >> mouseLeaveHandlerIn: anElement [

	^ BlEventHandler
		  on: BlMouseLeaveEvent
		  do: [ :event | self leaved: anElement event: event ]
]

{ #category : #'event handlers' }
ToMouseHandlingDresser >> mouseUpHandlerIn: anElement [

	^ BlEventHandler
		  on: BlMouseUpEvent
		  do: [ :event | self up: anElement event: event ]
]

{ #category : #'api - install/uninstall  hook' }
ToMouseHandlingDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMouseHandlingDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> pressed: anElement event: anEvent [

	^ anEvent
		  ifPrimary: [ self leftPressed: anElement event: anEvent ]
		  secondary: [ self rightPressed: anElement event: anEvent ]
		  middle: [ self middlePressed: anElement event: anEvent ]
		  other: [ self leftPressed: anElement event: anEvent ]
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> rightClicked: anElement event: anEvent [
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> rightPressed: anElement event: anEvent [

]

{ #category : #'events handling' }
ToMouseHandlingDresser >> rightUp: anElement event: anEvent [

]

{ #category : #'api - install/uninstall  hook' }
ToMouseHandlingDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: mouseDownHandler.
	anElement removeEventHandler: mouseUpHandler.
	anElement removeEventHandler: mouseClickHandler.
	anElement removeEventHandler: mouseDoubleClickHandler.
	anElement removeEventHandler: mouseEnterHandler.
	anElement removeEventHandler: mouseLeaveHandler
]

{ #category : #'events handling' }
ToMouseHandlingDresser >> up: anElement event: anEvent [

	^ anEvent
		  ifPrimary: [ self leftUp: anElement event: anEvent ]
		  secondary: [ self rightUp: anElement event: anEvent ]
		  middle: [ self middleUp: anElement event: anEvent ]
		  other: [ self leftUp: anElement event: anEvent ]
]
