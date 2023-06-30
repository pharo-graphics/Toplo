Class {
	#name : #ToResizeGripDresser,
	#superclass : #ToDresser,
	#instVars : [
		'mouseEnterHandler',
		'mouseLeaveHandler',
		'initialBorder',
		'initialBackground',
		'borderChangedHandler',
		'backgroundChangedHandler',
		'pullEndHandler',
		'mouseDownHandler'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - install/uninstall  hook' }
ToResizeGripDresser >> background: aBackground in: anElement [

	anElement
		disableEventType: BlElementBackgroundChangedEvent 
		while: [ anElement background: aBackground ]
]

{ #category : #'api - install/uninstall  hook' }
ToResizeGripDresser >> border: aBorder in: anElement [

	anElement
		disableEventType: BlElementBorderChangedEvent
		while: [ anElement border: aBorder ]
]

{ #category : #initialization }
ToResizeGripDresser >> defaultBackground [ 

	^ Color transparent
]

{ #category : #initialization }
ToResizeGripDresser >> defaultBorder [

	^ BlBorder empty
]

{ #category : #initialization }
ToResizeGripDresser >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: self defaultThickness 
]

{ #category : #initialization }
ToResizeGripDresser >> defaultThickness [

	^ 8
]

{ #category : #'event handling' }
ToResizeGripDresser >> hover: anElement [

	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement.
]

{ #category : #accessing }
ToResizeGripDresser >> hoveredBackground [

	^ Color lightGray alpha: 0.1 
]

{ #category : #accessing }
ToResizeGripDresser >> hoveredBorder [

	^ BlBorder paint: (Color lightGray alpha: 0.2)
]

{ #category : #accessing }
ToResizeGripDresser >> initialBackground: aBackground [

	initialBackground := aBackground
]

{ #category : #accessing }
ToResizeGripDresser >> initialBorder: aBorder [

	initialBorder := aBorder
]

{ #category : #'event handling' }
ToResizeGripDresser >> initialState: anElement [

	initialBorder := self defaultBorder.
	initialBackground := self defaultBackground.
	anElement thickness: self defaultThickness.
	anElement geometry: self defaultGeometry.
	anElement constraintsDo: [ :c | c ignoreByLayout ].

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToResizeGripDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	borderChangedHandler := BlEventHandler
		                        on: BlElementBorderChangedEvent
		                        do: [ self initialBorder: anElement border ].
	backgroundChangedHandler := BlEventHandler
		                            on: BlElementBackgroundChangedEvent
		                            do: [ 
		                            self initialBackground:
			                            anElement background ].
	mouseEnterHandler := BlEventHandler
		                     on: BlMouseEnterEvent
		                     do: [ :event | 
			                     (event anyButtonPressed and: [ 
				                      event currentTarget = anElement ]) ifFalse: [ 
				                     self hover: anElement ] ].
	mouseDownHandler := BlEventHandler
		                     on: BlMouseDownEvent
		                     do: [ :event | 
				                     self hover: anElement ].
	mouseLeaveHandler := BlEventHandler
		                     on: BlMouseLeaveEvent
		                     do: [ :event | 
			                     (event anyButtonPressed and: [ 
				                      event currentTarget = anElement ]) ifFalse: [ 
				                     self leaved: anElement ] ].
	pullEndHandler := BlEventHandler
		                  on: BlPullEndEvent
		                  do: [ self leaved: anElement ].

	anElement addEventHandler: borderChangedHandler.
	anElement addEventHandler: backgroundChangedHandler.
	anElement addEventHandler: mouseDownHandler.
	anElement addEventHandler: mouseEnterHandler.
	anElement addEventHandler: mouseLeaveHandler.
	anElement addEventHandler: pullEndHandler
]

{ #category : #'event handling' }
ToResizeGripDresser >> leaved: anElement [

	self border: initialBorder in: anElement.
	self background: initialBackground in: anElement


]

{ #category : #'api - install/uninstall  hook' }
ToResizeGripDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	self initialState: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToResizeGripDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToResizeGripDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: borderChangedHandler.
	anElement removeEventHandler: backgroundChangedHandler.
	anElement removeEventHandler: mouseDownHandler.
	anElement removeEventHandler: mouseEnterHandler.
	anElement removeEventHandler: mouseLeaveHandler.
	anElement removeEventHandler: pullEndHandler
]
