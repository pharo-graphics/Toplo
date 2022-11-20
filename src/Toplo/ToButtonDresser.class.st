Class {
	#name : #ToButtonDresser,
	#superclass : #ToWidgetDresser,
	#instVars : [
		'clickCandidateHandler',
		'mouseDownHandler',
		'mouseUpHandler',
		'mouseEnterHandler',
		'mouseLeaveHandler'
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

{ #category : #'api - hooks' }
ToButtonDresser >> installEventListenersIn: anElement [

	clickCandidateHandler := BlEventHandler on: BlClickCandidateEvent do: [ self escaped: anElement ].
	mouseDownHandler := BlEventHandler on: BlMouseDownEvent do: [ self pressed: anElement ].
	mouseUpHandler := BlEventHandler on: BlMouseUpEvent do: [ self clicked: anElement ].
	mouseEnterHandler := BlEventHandler on: BlMouseEnterEvent do: [ self hover: anElement ].
	mouseLeaveHandler := BlEventHandler on: BlMouseLeaveEvent do: [ self leaved: anElement ].
	anElement addEventHandler: clickCandidateHandler.
	anElement addEventHandler: mouseDownHandler.
	anElement addEventHandler: mouseUpHandler.
	anElement addEventHandler: mouseEnterHandler.
	anElement addEventHandler: mouseLeaveHandler.
]

{ #category : #'events handling' }
ToButtonDresser >> leaved: anElement [

	self subclassResponsibility 

]

{ #category : #'api - hooks' }
ToButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement.
	self installEventListenersIn: anElement
]

{ #category : #'api - hooks' }
ToButtonDresser >> onUninstalledIn: anElement [

	self uninstallEventListenersIn: anElement.
	super onUninstalledIn: anElement.

]

{ #category : #'events handling' }
ToButtonDresser >> pressed: anElement [

	self subclassResponsibility 

]

{ #category : #'api - hooks' }
ToButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: clickCandidateHandler.
	anElement removeEventHandler: mouseDownHandler.
	anElement removeEventHandler: mouseUpHandler.
	anElement removeEventHandler: mouseEnterHandler.
	anElement removeEventHandler: mouseLeaveHandler
]
