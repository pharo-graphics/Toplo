Class {
	#name : #ToButtonDresser,
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
ToButtonDresser >> backToUnpressedState [

	savedPressedBorder := nil.
	savedPressedBackground := nil.

]

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
ToButtonDresser >> doubleClicked: anElement [

	self backToUnpressedState.
	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement

]

{ #category : #accessing }
ToButtonDresser >> downBackground: aBackground [

	savedPressedBackground := aBackground

]

{ #category : #accessing }
ToButtonDresser >> downBorder: aBorder [

	savedPressedBorder := aBorder
]

{ #category : #'events handling' }
ToButtonDresser >> escaped: anElement [

	self backToUnpressedState

]

{ #category : #'events handling' }
ToButtonDresser >> hover: anElement [

	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement.
]

{ #category : #accessing }
ToButtonDresser >> hoveredBackground [

	^ savedPressedBackground ifNil: [ theme button hoveredBackgroundColor ]

]

{ #category : #accessing }
ToButtonDresser >> hoveredBorder [

	^ savedPressedBorder ifNil: [ BlBorder paint: theme button hoveredBorderColor ]

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

	initialBorder := BlBorder paint: self theme button defaultBorderColor.
	initialBackground := self theme button defaultBackgroundColor.
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

{ #category : #'events handling' }
ToButtonDresser >> leftClicked: anElement [
	
	super leftClicked: anElement.
	self backToUnpressedState.
	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement


]

{ #category : #'events handling' }
ToButtonDresser >> leftPressed: anElement [

	self savePressedState.
	self border: savedPressedBorder in: anElement.
	self background: savedPressedBackground in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement border:  (BlBorder paint: theme button defaultBorderColor width: 1).
	savedPressedBorder := nil.
	savedPressedBackground := nil
]

{ #category : #accessing }
ToButtonDresser >> pressedBackground [

	^ theme button pressedBackgroundColor
]

{ #category : #accessing }
ToButtonDresser >> pressedBorder [

	^ BlBorder paint: theme button pressedBorderColor width: 1
]

{ #category : #'events handling' }
ToButtonDresser >> savePressedState [

	self downBorder: self pressedBorder.
	self downBackground: self pressedBackground.

]

{ #category : #'api - install/uninstall  hook' }
ToButtonDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: borderChangedHandler.
	anElement removeEventHandler: backgroundChangedHandler.
	super uninstallEventListenersIn: anElement
]
