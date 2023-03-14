Class {
	#name : #ToDividerDresser,
	#superclass : #ToDresser,
	#instVars : [
		'dividerHandler',
		'firstTargetPositionChangeHandler',
		'secondTargetPositionChangeHandler',
		'mouseDownHandler',
		'mouseUpHandler',
		'mouseEnterHandler',
		'mouseLeaveHandler'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #accessing }
ToDividerDresser >> defaultHoveredBackground [  

	^ theme divider hoveredBackgroundColor

]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> defaultHoveredBorder [

	^ BlBorder paint: theme divider hoveredBorderColor

]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> defaultInitialBackground [

	^ self theme divider defaultBackgroundColor
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> defaultInitialBorder [

	^ BlBorder paint: self theme divider defaultBorderColor.

]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> defaultMargins [ 

	^ BlInsets all: 1
]

{ #category : #'events handling' }
ToDividerDresser >> hover: anElement event: anEvent [

	anElement border: (BlBorder paint: self theme divider hoveredBorderColor).
	anElement background: self theme divider hoveredBackgroundColor 
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> installEventListenersIn: anElement [

	anElement pane whenOrientationChangedDo: [ anElement adaptToPane ].
	
	mouseDownHandler := self mouseDownHandlerIn: anElement.
	mouseUpHandler := self mouseUpHandlerIn: anElement.
	mouseEnterHandler := self mouseEnterHandlerIn: anElement.
	mouseLeaveHandler := self mouseLeaveHandlerIn: anElement.
	dividerHandler := ToDividerEventHandler new divider: anElement.
	
	anElement addEventHandler: mouseDownHandler.
	anElement addEventHandler: mouseUpHandler.
	anElement addEventHandler: mouseEnterHandler.
	anElement addEventHandler: mouseLeaveHandler.
	anElement addEventHandler: dividerHandler.
	anElement addEventHandler: (self mouseClickHandlerIn: anElement).
	anElement addEventHandler: (self mouseClickCandidateHandlerIn: anElement).
	
	firstTargetPositionChangeHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ anElement adaptToPane ].	
	anElement firstTarget addEventHandler: firstTargetPositionChangeHandler.
	secondTargetPositionChangeHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ anElement adaptToPane ].	
	anElement secondTarget addEventHandler: secondTargetPositionChangeHandler.

]

{ #category : #'events handling' }
ToDividerDresser >> leaved: anElement [

	anElement border: (BlBorder paint: self theme divider defaultBorderColor).
	anElement background: self theme divider defaultBackgroundColor
]

{ #category : #'events handling' }
ToDividerDresser >> leftPressed: anElement event: anEvent [

	anElement border: (BlBorder paint: self theme divider pressedBorderColor).
	anElement background: self theme divider pressedBackgroundColor
]

{ #category : #'event handlers' }
ToDividerDresser >> mouseClickCandidateHandlerIn: anElement [

	^ BlEventHandler on: BlClickCandidateEvent do: [ :event | self up: anElement event: event]
]

{ #category : #'event handlers' }
ToDividerDresser >> mouseClickHandlerIn: anElement [

	^ BlEventHandler on: BlClickEvent do: [ :event | self up: anElement event: event]
]

{ #category : #'event handlers' }
ToDividerDresser >> mouseDownHandlerIn: anElement [

	^ BlEventHandler on: BlMouseDownEvent do: [ :event | self pressed: anElement event: event]
]

{ #category : #'event handlers' }
ToDividerDresser >> mouseEnterHandlerIn: anElement [

	^ BlEventHandler on: BlMouseEnterEvent 
		do: [ :event | 
			(event anyButtonPressed and: [event currentTarget ~= anElement ] )
				ifFalse: [self hover: anElement event: event] ]
]

{ #category : #'event handlers' }
ToDividerDresser >> mouseLeaveHandlerIn: anElement [

	^ BlEventHandler on: BlMouseLeaveEvent do: [ :event | event anyButtonPressed ifFalse: [ self leaved: anElement ] ]
]

{ #category : #'event handlers' }
ToDividerDresser >> mouseUpHandlerIn: anElement [

	^ BlEventHandler on: BlMouseUpEvent do: [ :event | self up: anElement event: event].
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self installEventListenersIn: anElement.
	anElement thickness: 3.
	anElement margin: self defaultMargins.
	anElement elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	anElement constraintsDo: [ :c | c ignoreByLayout ].
	anElement adaptToPane.

]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement.


]

{ #category : #'events handling' }
ToDividerDresser >> pressed: anElement event: anEvent [

	anEvent secondaryButtonPressed ifFalse: [ ^ self leftPressed: anElement event: anEvent].
	self rightPressed: anElement event: anEvent

]

{ #category : #accessing }
ToDividerDresser >> pressedBackground [

	^ theme divider pressedBackgroundColor
]

{ #category : #accessing }
ToDividerDresser >> pressedBorder [

	^ BlBorder paint: theme divider pressedBorderColor width: 1
]

{ #category : #'events handling' }
ToDividerDresser >> rightPressed: anElement event: anEvent [
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: mouseDownHandler.
	anElement removeEventHandler: mouseUpHandler.
	anElement removeEventHandler: mouseEnterHandler.
	anElement removeEventHandler: mouseLeaveHandler.
	anElement removeEventHandler: dividerHandler.
	
	anElement firstTarget removeEventHandler: firstTargetPositionChangeHandler.
	anElement secondTarget removeEventHandler: secondTargetPositionChangeHandler.

]

{ #category : #'events handling' }
ToDividerDresser >> up: anElement event: anEvent [

	self leaved: anElement.
	anElement adaptToPane
]
