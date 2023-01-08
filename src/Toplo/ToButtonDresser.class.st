Class {
	#name : #ToButtonDresser,
	#superclass : #ToAbstractButtonDresser,
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
ToButtonDresser >> background: aBackground in: anElement [

	anElement
		disableEventType: BlElementBackgroundChangedEvent 
		while: [ anElement background: aBackground ]
]

{ #category : #private }
ToButtonDresser >> border: aBorder in: anElement [

	anElement
		disableEventType: BlElementBorderChangedEvent
		while: [ anElement border: aBorder ]
]

{ #category : #'events handling' }
ToButtonDresser >> clicked: anElement [

	downBorder := nil.
	self border: self hoveredBorder in: anElement

]

{ #category : #'events handling' }
ToButtonDresser >> doubleClicked: anElement [

	downBorder := nil.
	self border: self hoveredBorder in: anElement

]

{ #category : #'events handling' }
ToButtonDresser >> escaped: anElement [

	downBorder := nil.
	
]

{ #category : #'events handling' }
ToButtonDresser >> hover: anElement [

	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement.
]

{ #category : #'border accessing' }
ToButtonDresser >> hoveredBackground [

	^ downBackground ifNil: [ theme button hoveredBorderColor alpha: 0.1 ]

]

{ #category : #'border accessing' }
ToButtonDresser >> hoveredBackground: aBackground [

	downBackground := aBackground

]

{ #category : #'border accessing' }
ToButtonDresser >> hoveredBorder [

	^ downBorder ifNil: [ BlBorder paint: theme button hoveredBorderColor ]

]

{ #category : #accessing }
ToButtonDresser >> initialBackground: aBackground [

	initialBackground := aBackground
]

{ #category : #accessing }
ToButtonDresser >> initialBorder: aBorder [

	initialBorder := aBorder
]

{ #category : #'events handling' }
ToButtonDresser >> initialState: anElement [

	initialBorder ifNil: [ initialBorder := anElement border ].
	initialBackground ifNil: [ initialBackground := anElement background ].
	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> installEventListenersIn: anElement [

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
ToButtonDresser >> leaved: anElement [

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement


]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement border:  (BlBorder paint: theme button defaultBorderColor width: 1).
	downBorder := nil.
	downBackground := nil
]

{ #category : #'events handling' }
ToButtonDresser >> pressed: anElement [

	self border: self pressedBorder in: anElement.
	downBorder := anElement border.
	self hoveredBackground: anElement background.

]

{ #category : #'border accessing' }
ToButtonDresser >> pressedBackground [

	^ theme button pressedBackground
]

{ #category : #'border accessing' }
ToButtonDresser >> pressedBorder [

	^ BlBorder paint: theme button pressedBorderColor width: 2
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: borderChangedHandler.
	anElement removeEventHandler: backgroundChangedHandler.
	super uninstallEventListenersIn: anElement
]
