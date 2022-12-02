Class {
	#name : #ToButtonDefaultDresser,
	#superclass : #ToButtonDresser,
	#instVars : [
		'downBorder',
		'initialBorder',
		'borderChangedHandler',
		'downBackground',
		'initialBackground',
		'backgroundChangedHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #private }
ToButtonDefaultDresser >> background: aBackground in: anElement [

	self
		disableBackgroundChangeEventIn: anElement
		while: [ anElement background: aBackground ]
]

{ #category : #private }
ToButtonDefaultDresser >> border: aBorder in: anElement [

	self
		disableBorderChangeEventIn: anElement
		while: [ anElement border: aBorder ]
]

{ #category : #'events handling' }
ToButtonDefaultDresser >> clicked: anElement [

	downBorder := nil.
	self border: self hoveredBorder in: anElement

]

{ #category : #private }
ToButtonDefaultDresser >> disableBackgroundChangeEventIn: anElement while: aBlock [

	anElement eventDispatcher disableEventType: BlElementBackgroundChangedEvent.
	aBlock ensure: [ 
		anElement eventDispatcher enableEventType: BlElementBackgroundChangedEvent ]
]

{ #category : #private }
ToButtonDefaultDresser >> disableBorderChangeEventIn: anElement while: aBlock [

	anElement eventDispatcher disableEventType: BlElementBorderChangedEvent.
	aBlock ensure: [ 
		anElement eventDispatcher enableEventType: BlElementBorderChangedEvent ]
]

{ #category : #'events handling' }
ToButtonDefaultDresser >> escaped: anElement [

	downBorder := nil.
	
]

{ #category : #'events handling' }
ToButtonDefaultDresser >> hover: anElement [

	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement.
]

{ #category : #'border accessing' }
ToButtonDefaultDresser >> hoveredBackground [

	^ downBackground ifNil: [ theme button hoveredBorderColor alpha: 0.1 ]

]

{ #category : #'border accessing' }
ToButtonDefaultDresser >> hoveredBorder [

	^ downBorder ifNil: [ BlBorder paint: theme button hoveredBorderColor ]

]

{ #category : #accessing }
ToButtonDefaultDresser >> initialBackground: aBackground [

	initialBackground := aBackground
]

{ #category : #accessing }
ToButtonDefaultDresser >> initialBorder: aBorder [

	initialBorder := aBorder
]

{ #category : #'events handling' }
ToButtonDefaultDresser >> initialState: anElement [

	initialBorder ifNil: [ initialBorder := anElement border ].
	initialBackground ifNil: [ initialBackground := anElement background ].
	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	borderChangedHandler := BlEventHandler
		                        on: BlElementBorderChangedEvent
		                        do: [ self initialBorder: anElement border ].
	backgroundChangedHandler := BlEventHandler
		                        on: BlElementBackgroundChangedEvent
		                        do: [ self initialBackground: anElement background ].
	anElement addEventHandler: borderChangedHandler.
	anElement addEventHandler: backgroundChangedHandler
]

{ #category : #'events handling' }
ToButtonDefaultDresser >> leaved: anElement [

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement


]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement border:  (BlBorder paint: theme button defaultBorderColor width: 1).
	downBorder := nil.
	downBackground := nil
]

{ #category : #'events handling' }
ToButtonDefaultDresser >> pressed: anElement [

	self border: self pressedBorder in: anElement.
	downBorder := anElement border.
	downBackground := anElement background.

]

{ #category : #'border accessing' }
ToButtonDefaultDresser >> pressedBackground [

	^ theme button pressedBackground
]

{ #category : #'border accessing' }
ToButtonDefaultDresser >> pressedBorder [

	^ BlBorder paint: theme button pressedBorderColor width: 2
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: borderChangedHandler.
	anElement removeEventHandler: backgroundChangedHandler.
	super uninstallEventListenersIn: anElement
]
