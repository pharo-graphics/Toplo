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
	#category : #'Toplo-Widget-Buttons'
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

	^ downBackground ifNil: [ Color lightGray alpha: 0.2 ]

]

{ #category : #'border accessing' }
ToButtonDefaultDresser >> hoveredBorder [

	^ downBorder ifNil: [ initialBackground ]

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

{ #category : #'api - hooks' }
ToButtonDefaultDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	borderChangedHandler := BlEventHandler
		                        on: BlElementBorderChangedEvent
		                        do: [ self initialBorder: anElement border ].
	backgroundChangedHandler := BlEventHandler
		                        on: BlElementBackgroundChangedEvent
		                        do: [ self initialBackground: anElement border ].
	anElement addEventHandler: borderChangedHandler.
	anElement addEventHandler: backgroundChangedHandler
]

{ #category : #'events handling' }
ToButtonDefaultDresser >> leaved: anElement [

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement


]

{ #category : #'api - hooks' }
ToButtonDefaultDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
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

	^ Color gray alpha: 0.3
]

{ #category : #'border accessing' }
ToButtonDefaultDresser >> pressedBorder [

	^ BlBorder paint: Color gray width: 2
]

{ #category : #'api - hooks' }
ToButtonDefaultDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: borderChangedHandler.
	anElement removeEventHandler: backgroundChangedHandler.
	super uninstallEventListenersIn: anElement
]
