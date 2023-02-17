Class {
	#name : #ToPairedButtonDresser,
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

{ #category : #'events handling' }
ToPairedButtonDresser >> backToUnpressedState [

	savedPressedBorder := nil.
	savedPressedBackground := nil.

]

{ #category : #private }
ToPairedButtonDresser >> background: aBackground in: anElement [

	anElement
		disableEventType: BlElementBackgroundChangedEvent 
		while: [ anElement background: aBackground ]
]

{ #category : #private }
ToPairedButtonDresser >> border: aBorder in: anElement [

	anElement
		disableEventType: BlElementBorderChangedEvent
		while: [ anElement border: aBorder ]
]

{ #category : #accessing }
ToPairedButtonDresser >> defaultHoveredBackground [  

	^ theme button hoveredBackgroundColor

]

{ #category : #'api - install/uninstall  hook' }
ToPairedButtonDresser >> defaultHoveredBorder [

	^ BlBorder paint: theme button hoveredBorderColor

]

{ #category : #'api - install/uninstall  hook' }
ToPairedButtonDresser >> defaultInitialBackground [

	^ self theme button defaultBackgroundColor
]

{ #category : #'api - install/uninstall  hook' }
ToPairedButtonDresser >> defaultInitialBorder [

	^ BlBorder paint: self theme button defaultBorderColor.

]

{ #category : #'events handling' }
ToPairedButtonDresser >> doubleClicked: anElement [

	self backToUnpressedState.
	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement

]

{ #category : #'events handling' }
ToPairedButtonDresser >> escaped: anElement [

	self backToUnpressedState

]

{ #category : #'events handling' }
ToPairedButtonDresser >> hover: anElement [

	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement.
]

{ #category : #accessing }
ToPairedButtonDresser >> hoveredBackground [

	^ savedPressedBackground ifNil: [ self defaultHoveredBackground ]

]

{ #category : #accessing }
ToPairedButtonDresser >> hoveredBorder [

	^ savedPressedBorder ifNil: [ self defaultHoveredBorder ]

]

{ #category : #accessing }
ToPairedButtonDresser >> initialBackground: aBackground [

	initialBackground := aBackground
]

{ #category : #accessing }
ToPairedButtonDresser >> initialBorder: aBorder [

	initialBorder := aBorder
]

{ #category : #'events handling' }
ToPairedButtonDresser >> initialState: anElement [

	initialBorder := self defaultInitialBorder.
	initialBackground := self defaultInitialBackground.

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToPairedButtonDresser >> installEventListenersIn: anElement [

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
ToPairedButtonDresser >> leaved: anElement [

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement


]

{ #category : #'events handling' }
ToPairedButtonDresser >> leftClicked: anElement [
	
	super leftClicked: anElement.
	self backToUnpressedState.
	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement


]

{ #category : #'events handling' }
ToPairedButtonDresser >> leftPressed: anElement [

	self savePressedState.
	self border: savedPressedBorder in: anElement.
	self background: savedPressedBackground in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPairedButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement border:  (BlBorder paint: theme button defaultBorderColor width: 1).
	savedPressedBorder := nil.
	savedPressedBackground := nil
]

{ #category : #accessing }
ToPairedButtonDresser >> pressedBackground [

	^ theme button pressedBackgroundColor
]

{ #category : #accessing }
ToPairedButtonDresser >> pressedBorder [

	^ BlBorder paint: theme button pressedBorderColor width: 1
]

{ #category : #'events handling' }
ToPairedButtonDresser >> savePressedState [

	self savedPressedBorder: self pressedBorder.
	self savedPressedBackground: self pressedBackground.

]

{ #category : #accessing }
ToPairedButtonDresser >> savedPressedBackground: aBackground [

	savedPressedBackground := aBackground

]

{ #category : #accessing }
ToPairedButtonDresser >> savedPressedBorder: aBorder [

	savedPressedBorder := aBorder
]

{ #category : #'api - install/uninstall  hook' }
ToPairedButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: borderChangedHandler.
	anElement removeEventHandler: backgroundChangedHandler.
	super uninstallEventListenersIn: anElement
]
