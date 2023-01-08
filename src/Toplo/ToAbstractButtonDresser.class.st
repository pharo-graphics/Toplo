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
		'mouseDoubleClickHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #accessing }
ToAbstractButtonDresser >> clickActionLauncher [

	^ ToButtonClickActionLauncher new
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> clicked: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> clicked: anElement event: anEvent [

	self clicked: anElement

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> doubleClicked: anElement [ 

	self clicked: anElement

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> doubleClicked: anElement event: anEvent [

	self doubleClicked: anElement

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> escaped: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> hover: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> hover: anElement event: anEvent [

	self hover: anElement

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> initialState: anElement [

	self subclassResponsibility 

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> installEventListenersIn: anElement [

	clickActionLauncher := self clickActionLauncher button: anElement.
	clickCandidateHandler := BlEventHandler on: BlClickCandidateEvent do: [ self escaped: anElement ].
	mouseDownHandler := BlEventHandler on: BlMouseDownEvent do: [ :event | self pressed: anElement ].
	mouseClickHandler := BlEventHandler on: BlClickEvent do: [ :event | self clicked: anElement event: event].
	mouseDoubleClickHandler := BlEventHandler on: BlDoubleClickEvent do: [ :event | self doubleClicked: anElement event: event].
	mouseEnterHandler := BlEventHandler on: BlMouseEnterEvent 
		do: [ :event | 
			(event anyButtonPressed and: [event currentTarget ~= anElement ] )
				ifFalse: [self hover: anElement event: event] ].

	mouseLeaveHandler := BlEventHandler on: BlMouseLeaveEvent do: [ self leaved: anElement ].
	anElement addEventHandler: clickCandidateHandler.
	anElement addEventHandler: mouseDownHandler.
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

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement.
	anElement outskirts: (BlOutskirts outside).
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> onUninstalledIn: anElement [

	self uninstallEventListenersIn: anElement.
	super onUninstalledIn: anElement.

]

{ #category : #'events handling' }
ToAbstractButtonDresser >> pressed: anElement [

	self subclassResponsibility 

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: clickCandidateHandler.
	anElement removeEventHandler: mouseDownHandler.
	anElement removeEventHandler: mouseClickHandler.
	anElement removeEventHandler: mouseDoubleClickHandler.
	anElement removeEventHandler: mouseEnterHandler.
	anElement removeEventHandler: mouseLeaveHandler.
	anElement removeEventHandler: clickActionLauncher.
]
