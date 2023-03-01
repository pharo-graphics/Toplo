Class {
	#name : #ToGeneralButtonDresser,
	#superclass : #ToAbstractButtonDresser,
	#instVars : [
		'initialBorder',
		'borderChangedHandler',
		'initialBackground',
		'backgroundChangedHandler',
		'savedPressedBackground',
		'savedPressedBorder'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #private }
ToGeneralButtonDresser >> background: aBackground in: anElement [

	anElement
		disableEventType: BlElementBackgroundChangedEvent 
		while: [ anElement background: aBackground ]
]

{ #category : #private }
ToGeneralButtonDresser >> border: aBorder in: anElement [

	anElement
		disableEventType: BlElementBorderChangedEvent
		while: [ anElement border: aBorder ]
]

{ #category : #accessing }
ToGeneralButtonDresser >> defaultHoveredBackground [  

	^ theme button hoveredBackgroundColor

]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> defaultHoveredBorder [

	^ BlBorder paint: theme button hoveredBorderColor

]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> defaultInitialBackground [

	^ self theme button defaultBackgroundColor
]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> defaultInitialBorder [

	^ BlBorder paint: self theme button defaultBorderColor.

]

{ #category : #'events handling' }
ToGeneralButtonDresser >> escaped: anElement [

	self restoreUnpressedState

]

{ #category : #'events handling' }
ToGeneralButtonDresser >> hover: anElement event: anEvent [

	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement.
]

{ #category : #accessing }
ToGeneralButtonDresser >> hoveredBackground [

	^ savedPressedBackground ifNil: [ self defaultHoveredBackground ]

]

{ #category : #accessing }
ToGeneralButtonDresser >> hoveredBorder [

	^ savedPressedBorder ifNil: [ self defaultHoveredBorder ]

]

{ #category : #accessing }
ToGeneralButtonDresser >> initialBackground: aBackground [

	initialBackground := aBackground
]

{ #category : #accessing }
ToGeneralButtonDresser >> initialBorder: aBorder [

	initialBorder := aBorder
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> initialState: anElement [

	initialBorder := self defaultInitialBorder.
	initialBackground := self defaultInitialBackground.

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> installEventListenersIn: anElement [

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
ToGeneralButtonDresser >> leaved: anElement [

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement


]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftClicked: anElement [

	super leftClicked: anElement.
	self restoreUnpressedState.
	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement


]

{ #category : #'events handling' }
ToGeneralButtonDresser >> leftPressed: anElement event: anEvent [

	self savePressedState.
	self border: savedPressedBorder in: anElement.
	self background: savedPressedBackground in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	savedPressedBorder := nil.
	savedPressedBackground := nil
]

{ #category : #accessing }
ToGeneralButtonDresser >> pressedBackground [

	^ theme button pressedBackgroundColor
]

{ #category : #accessing }
ToGeneralButtonDresser >> pressedBorder [

	^ BlBorder paint: theme button pressedBorderColor width: 1
]

{ #category : #'events handling' }
ToGeneralButtonDresser >> restoreUnpressedState [

	savedPressedBorder := nil.
	savedPressedBackground := nil.

]

{ #category : #'events handling' }
ToGeneralButtonDresser >> savePressedState [

	self savedPressedBorder: self pressedBorder.
	self savedPressedBackground: self pressedBackground.

]

{ #category : #accessing }
ToGeneralButtonDresser >> savedPressedBackground: aBackground [

	savedPressedBackground := aBackground

]

{ #category : #accessing }
ToGeneralButtonDresser >> savedPressedBorder: aBorder [

	savedPressedBorder := aBorder
]

{ #category : #'api - install/uninstall  hook' }
ToGeneralButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: borderChangedHandler.
	anElement removeEventHandler: backgroundChangedHandler.
	super uninstallEventListenersIn: anElement
]
