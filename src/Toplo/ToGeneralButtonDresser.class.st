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

{ #category : #accessing }
ToGeneralButtonDresser >> colorProvider [

	^ self theme button
]

{ #category : #accessing }
ToGeneralButtonDresser >> defaultHoveredBackground [  

	^ self colorProvider hoveredBackgroundColor

]

{ #category : #accessing }
ToGeneralButtonDresser >> defaultHoveredBorder [

	^ BlBorder paint: self colorProvider hoveredBorderColor

]

{ #category : #accessing }
ToGeneralButtonDresser >> defaultInitialBackground [

	^ self colorProvider defaultBackgroundColor
]

{ #category : #accessing }
ToGeneralButtonDresser >> defaultInitialBorder [

	^ BlBorder paint: self colorProvider defaultBorderColor.

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

	^ self colorProvider pressedBackgroundColor
]

{ #category : #accessing }
ToGeneralButtonDresser >> pressedBorder [

	^ BlBorder paint: self colorProvider pressedBorderColor width: 1
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
	
	borderChangedHandler := nil.
	backgroundChangedHandler := nil.
	
	super uninstallEventListenersIn: anElement.
]
