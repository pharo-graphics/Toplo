Class {
	#name : #ToButtonDresser,
	#superclass : #ToWidgetDresser,
	#instVars : [
		'clickCandidateHandler',
		'mouseDownHandler',
		'mouseUpHandler',
		'mouseEnterHandler',
		'mouseLeaveHandler',
		'clickHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'events handling' }
ToButtonDresser >> clicked: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToButtonDresser >> escaped: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToButtonDresser >> hover: anElement [

	self subclassResponsibility 

]

{ #category : #'events handling' }
ToButtonDresser >> initialState: anElement [

	self subclassResponsibility 

]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> installEventListenersIn: anElement [

	clickCandidateHandler := BlEventHandler on: BlClickCandidateEvent do: [ self escaped: anElement ].

	clickHandler := ToButtonClickEventHandler new button: anElement.
	mouseDownHandler := BlEventHandler on: BlMouseDownEvent do: [ self pressed: anElement ].
	mouseUpHandler := BlEventHandler on: BlMouseUpEvent do: [ self clicked: anElement ].
	mouseEnterHandler := BlEventHandler on: BlMouseEnterEvent 
		do: [ :event | 
			(event anyButtonPressed and: [event currentTarget ~= anElement ] )
				ifFalse: [self hover: anElement ] ].
	mouseLeaveHandler := BlEventHandler on: BlMouseLeaveEvent do: [ self leaved: anElement ].
	anElement addEventHandler: clickCandidateHandler.
	anElement addEventHandler: mouseDownHandler.
	anElement addEventHandler: mouseUpHandler.
	anElement addEventHandler: mouseEnterHandler.
	anElement addEventHandler: mouseLeaveHandler.
	anElement addEventHandler: clickHandler.


]

{ #category : #'events handling' }
ToButtonDresser >> leaved: anElement [

	self subclassResponsibility 

]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement.
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> onUninstalledIn: anElement [

	self uninstallEventListenersIn: anElement.
	super onUninstalledIn: anElement.

]

{ #category : #'events handling' }
ToButtonDresser >> pressed: anElement [

	self subclassResponsibility 

]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: clickCandidateHandler.
	anElement removeEventHandler: mouseDownHandler.
	anElement removeEventHandler: mouseUpHandler.
	anElement removeEventHandler: mouseEnterHandler.
	anElement removeEventHandler: mouseLeaveHandler.
	anElement removeEventHandler: clickHandler.
]
