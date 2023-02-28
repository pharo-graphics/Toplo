Class {
	#name : #ToAbstractButtonDresser,
	#superclass : #ToDresser,
	#instVars : [
		'clickCandidateHandler',
		'mouseDownHandler',
		'mouseEnterHandler',
		'mouseLeaveHandler',
		'clickActionLauncher',
		'mouseClickHandler',
		'mouseDoubleClickHandler',
		'mouseUpHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #accessing }
ToAbstractButtonDresser >> clickActionLauncher [

	^ ToClickHandler new
]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> clickCandidateHandlerIn: anElement [

	^ BlEventHandler on: BlClickCandidateEvent do: [ self escaped: anElement ]
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> clicked: anElement event: anEvent [

	anEvent secondaryButtonPressed ifTrue: [ ^ self rightClicked: anElement event: anEvent ].
	self leftClicked: anElement event: anEvent

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> doubleClicked: anElement event: anEvent [

	self clicked: anElement event: anEvent

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> escaped: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> hover: anElement event: anEvent [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> initialState: anElement [

	self subclassResponsibility 

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> installEventListenersIn: anElement [

	clickActionLauncher := self clickActionLauncher button: anElement.
	clickCandidateHandler := self clickCandidateHandlerIn: anElement.
	mouseDownHandler := self mouseDownHandlerIn: anElement.
	mouseUpHandler := self mouseUpHandlerIn: anElement.
	mouseClickHandler := self mouseClickHandlerIn: anElement.
	mouseDoubleClickHandler := self mouseDoubleClickHandlerIn: anElement.
	mouseEnterHandler := self mouseEnterHandlerIn: anElement.
	mouseLeaveHandler := self mouseLeaveHandlerIn: anElement.
	
	anElement addEventHandler: clickCandidateHandler.
	anElement addEventHandler: mouseDownHandler.
	anElement addEventHandler: mouseUpHandler.
	anElement addEventHandler: mouseClickHandler.
	anElement addEventHandler: mouseDoubleClickHandler.
	anElement addEventHandler: mouseEnterHandler.
	anElement addEventHandler: mouseLeaveHandler.
	anElement addEventHandler: clickActionLauncher.


]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leaved: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leftClicked: anElement [

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leftClicked: anElement event: anEvent [

	self leftClicked: anElement
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leftPressed: anElement event: anEvent [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> leftUp: anElement event: anEvent [

]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> mouseClickHandlerIn: anElement [

	^ BlEventHandler
		  on: BlClickEvent
		  do: [ :event |
			  self clicked: anElement event: event ]
]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> mouseDoubleClickHandlerIn: anElement [

	^ BlEventHandler on: BlDoubleClickEvent do: [ :event | self doubleClicked: anElement event: event].
]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> mouseDownHandlerIn: anElement [

	^ BlEventHandler on: BlMouseDownEvent do: [ :event | self pressed: anElement event: event]
]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> mouseEnterHandlerIn: anElement [

	^ BlEventHandler on: BlMouseEnterEvent 
		do: [ :event | 
			(event anyButtonPressed and: [event currentTarget ~= anElement ] )
				ifFalse: [self hover: anElement event: event] ]
]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> mouseLeaveHandlerIn: anElement [

	^ BlEventHandler on: BlMouseLeaveEvent do: [ self leaved: anElement ]
]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> mouseUpHandlerIn: anElement [

	^ BlEventHandler on: BlMouseUpEvent do: [ :event | self up: anElement event: event].
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement.
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> onUninstalledIn: anElement [

	self uninstallEventListenersIn: anElement.
	super onUninstalledIn: anElement.

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> pressed: anElement event: anEvent [

	anEvent secondaryButtonPressed ifFalse: [ ^ self leftPressed: anElement event: anEvent].
	self rightPressed: anElement event: anEvent

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> rightClicked: anElement event: anEvent [
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> rightPressed: anElement event: anEvent [
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> rightUp: anElement event: anEvent [
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: clickCandidateHandler.
	anElement removeEventHandler: mouseDownHandler.
	anElement removeEventHandler: mouseUpHandler.
	anElement removeEventHandler: mouseClickHandler.
	anElement removeEventHandler: mouseDoubleClickHandler.
	anElement removeEventHandler: mouseEnterHandler.
	anElement removeEventHandler: mouseLeaveHandler.
	anElement removeEventHandler: clickActionLauncher
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> up: anElement event: anEvent [

	anEvent primaryButtonPressed ifTrue: [ ^ self leftUp: anElement event: anEvent].
	self rightUp: anElement event: anEvent
]
