Class {
	#name : #ToDividerDresser,
	#superclass : #ToWidgetDresser,
	#instVars : [
		'dividerHandler',
		'firstTargetPositionChangeHandler',
		'secondTargetPositionChangeHandler',
		'dragEndHandler',
		'paneExtentHandler'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #accessing }
ToDividerDresser >> colorProvider [ 

	^ self theme divider
]

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

	^ BlEventHandler on: BlDragEndEvent do: [ :event | self mouseUpEvent: event in: anElement].
]

{ #category : #'events handling' }
ToDividerDresser >> hover: anElement event: anEvent [

	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith:
			'`@receiver hover: `@anElement event: `@anEvent'
				-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
	super hover: anElement event: anEvent.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	anElement border: (BlBorder paint: self colorProvider hoveredBorderColor).
	anElement background: self colorProvider hoveredBackgroundColor
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> initialState: anElement [

	anElement thickness: 4.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement border: (BlBorder paint: self colorProvider defaultBorderColor).
	anElement background: self colorProvider defaultBackgroundColor.
	anElement margin: self defaultMargins.
	anElement padding: self defaultPadding.
	anElement elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	anElement constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.	
	dragEndHandler := self dragEndHandlerIn: anElement.

	dividerHandler := ToDividerEventHandler new divider: anElement.
	
	anElement addEventHandler: dragEndHandler.
	anElement addEventHandler: dividerHandler.
	
	paneExtentHandler := self paneExtentChangeHandlerIn: anElement.
	anElement pane addEventHandler: paneExtentHandler.
	
	firstTargetPositionChangeHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ anElement requestLayout ].	
	secondTargetPositionChangeHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ anElement requestLayout ].
	anElement firstTarget addEventHandler: firstTargetPositionChangeHandler.
	anElement secondTarget addEventHandler: secondTargetPositionChangeHandler.

	

]

{ #category : #'events handling' }
ToDividerDresser >> leaved: anElement event: anEvent [

	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith:
			'`@receiver leaved: `@anElement event: `@anEvent'
				-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.
	super leaved: anElement event: anEvent.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	anElement border: (BlBorder paint: self colorProvider defaultBorderColor).
	anElement background: self colorProvider defaultBackgroundColor
]

{ #category : #'events handling' }
ToDividerDresser >> leftMouseDownEvent: anEvent in: anElement [

	super leftMouseDownEvent: anEvent in: anElement.
	anElement border: (BlBorder paint: self colorProvider pressedBorderColor).
	anElement background: self colorProvider pressedBackgroundColor
]

{ #category : #'events handling' }
ToDividerDresser >> leftMouseUpEvent: anEvent in: anElement [

	super leftMouseUpEvent: anEvent in: anElement.
	anElement border: (BlBorder paint: self colorProvider defaultBorderColor).
	anElement background: self colorProvider defaultBackgroundColor.
	anElement space mouseProcessor handleLastMouseMove
]

{ #category : #'events handling' }
ToDividerDresser >> leftPressed: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver leftPressed: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseDownEvent: `@anEvent in: `@anElement'.

	super leftPressed: anElement event: anEvent.
	anElement border: (BlBorder paint: self colorProvider pressedBorderColor).
	anElement background: self colorProvider pressedBackgroundColor
]

{ #category : #'events handling' }
ToDividerDresser >> leftUp: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseUpEvent:in: instead.'
		transformWith:
			'`@receiver leftUp: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseUpEvent: `@anEvent in: `@anElement'.
				
	super leftUp: anElement event: anEvent.
	anElement border: (BlBorder paint: self colorProvider defaultBorderColor).
	anElement background: self colorProvider defaultBackgroundColor.
	anElement space mouseProcessor handleLastMouseMove
]

{ #category : #'events handling' }
ToDividerDresser >> mouseEnterEvent: anEvent in: anElement [

	super mouseEnterEvent: anEvent in: anElement.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	anElement border: (BlBorder paint: self colorProvider hoveredBorderColor).
	anElement background: self colorProvider hoveredBackgroundColor
]

{ #category : #'events handling' }
ToDividerDresser >> mouseLeaveEvent: anEvent in: anElement [

	super mouseLeaveEvent: anEvent in: anElement.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	anElement border: (BlBorder paint: self colorProvider defaultBorderColor).
	anElement background: self colorProvider defaultBackgroundColor
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'event handlers' }
ToDividerDresser >> paneExtentChangeHandlerIn: anElement [

	^ BlEventHandler on: BlElementExtentChangedEvent do: [ :event | anElement requestLayout ].

]

{ #category : #accessing }
ToDividerDresser >> pressedBackground [

	^ self colorProvider pressedBackgroundColor
]

{ #category : #accessing }
ToDividerDresser >> pressedBorder [

	^ BlBorder paint: self colorProvider pressedBorderColor width: 1
]

{ #category : #'api - install/uninstall  hook' }
ToDividerDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: dragEndHandler.
	anElement removeEventHandler: dividerHandler.
	
	anElement pane removeEventHandler: paneExtentHandler.
	anElement firstTarget removeEventHandler: firstTargetPositionChangeHandler.
	anElement secondTarget removeEventHandler: secondTargetPositionChangeHandler.



]
