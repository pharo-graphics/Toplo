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
		'mouseLeaveHandler',
		'dragEndHandler',
		'paneExtentHandler'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> defaultMargins [ 

	^ BlInsets empty
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> defaultPadding [

	^ BlInsets empty
]

{ #category : #'event handlers' }
ToDividerDresser >> dragEndHandlerIn: anElement [

	^ BlEventHandler on: BlDragEndEvent do: [ :event | self up: anElement event: event ].
]

{ #category : #'events handling' }
ToDividerDresser >> hover: anElement event: anEvent [

	anElement border: (BlBorder paint: self theme divider hoveredBorderColor).
	anElement background: self theme divider hoveredBackgroundColor
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> installEventListenersIn: anElement [

	anElement pane whenOrientationChangedDo: [ anElement requestLayout ].
	anElement pane whenDirectionChangedDo: [ anElement requestLayout ].
	
	mouseDownHandler := self mouseDownHandlerIn: anElement.
	mouseUpHandler := self mouseUpHandlerIn: anElement.
	dragEndHandler := self dragEndHandlerIn: anElement.
	mouseEnterHandler := self mouseEnterHandlerIn: anElement.
	mouseLeaveHandler := self mouseLeaveHandlerIn: anElement.

	dividerHandler := ToDividerEventHandler new divider: anElement.
	
	anElement addEventHandler: mouseDownHandler.
	anElement addEventHandler: mouseUpHandler.
	anElement addEventHandler: dragEndHandler.
	anElement addEventHandler: mouseEnterHandler.
	anElement addEventHandler: mouseLeaveHandler.
	anElement addEventHandler: dividerHandler.
	
	paneExtentHandler := self paneExtentChangeHandlerIn: anElement.
	anElement pane addEventHandler: paneExtentHandler.
	
	firstTargetPositionChangeHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ anElement requestLayout ].	
	anElement firstTarget addEventHandler: firstTargetPositionChangeHandler.
	secondTargetPositionChangeHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ anElement requestLayout ].	
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
	anElement thickness: 4.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement border: (BlBorder paint: self theme divider defaultBorderColor).
	anElement background: self theme divider defaultBackgroundColor.
	anElement margin: self defaultMargins.
	anElement padding: self defaultPadding.
	anElement elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	anElement constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement.


]

{ #category : #'event handlers' }
ToDividerDresser >> paneExtentChangeHandlerIn: anElement [

	^ BlEventHandler on: BlElementExtentChangedEvent do: [ :event | anElement requestLayout ].

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
	anElement removeEventHandler: dragEndHandler.
	anElement removeEventHandler: mouseEnterHandler.
	anElement removeEventHandler: mouseLeaveHandler.
	anElement removeEventHandler: dividerHandler.
	
	anElement pane removeEventHandler: paneExtentHandler.

	anElement firstTarget removeEventHandler: firstTargetPositionChangeHandler.
	anElement secondTarget removeEventHandler: secondTargetPositionChangeHandler.

]

{ #category : #'events handling' }
ToDividerDresser >> up: anElement event: anEvent [

	self leaved: anElement.
	anElement space mouseProcessor handleLastMouseMove
]
