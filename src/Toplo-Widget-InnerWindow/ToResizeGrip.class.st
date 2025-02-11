Class {
	#name : #ToResizeGrip,
	#superclass : #ToElement,
	#instVars : [
		'thickness',
		'initialDragPosition',
		'initialBorder',
		'initialBackground',
		'initialPosition',
		'initialSize'
	],
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToResizeGrip >> cursorSelector [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToResizeGrip >> defaultBackground [ 

	^ Color transparent
]

{ #category : #initialization }
ToResizeGrip >> defaultBorder [

	^ BlBorder empty
]

{ #category : #initialization }
ToResizeGrip >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: self defaultThickness 
]

{ #category : #initialization }
ToResizeGrip >> defaultThickness [

	^ 7
]

{ #category : #'mouse processing' }
ToResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	self subclassResponsibility 
]

{ #category : #initialization }
ToResizeGrip >> hoveredBackground [

	^ Color lightGray alpha: 0.1 
]

{ #category : #initialization }
ToResizeGrip >> hoveredBorder [

	^ BlBorder paint: (Color lightGray alpha: 0.2)
]

{ #category : #accessing }
ToResizeGrip >> initialBackground [

	^ initialBackground 
]

{ #category : #accessing }
ToResizeGrip >> initialBorder [

	^ initialBorder 
]

{ #category : #accessing }
ToResizeGrip >> initialDragPosition [

	^ initialDragPosition
]

{ #category : #accessing }
ToResizeGrip >> initialDragPosition: aPoint [

	initialDragPosition := aPoint
]

{ #category : #accessing }
ToResizeGrip >> initialPosition: aPoint [

	initialPosition := aPoint
]

{ #category : #accessing }
ToResizeGrip >> initialSize: aPoint [

	initialSize := aPoint
]

{ #category : #initialization }
ToResizeGrip >> initialize [

	super initialize.
	
	self layout: BlFrameLayout new.
	initialBorder := self defaultBorder.
	initialBackground := self defaultBackground.
	self thickness: self defaultThickness.
	self geometry: self defaultGeometry.
	self constraintsDo: [ :c | c ignoreByLayout ].

	self border: initialBorder.
	self background: initialBackground

]

{ #category : #'mouse processing' }
ToResizeGrip >> layoutIn: anElement [

	self subclassResponsibility 
]

{ #category : #accessing }
ToResizeGrip >> resizeCursor [

	^ Cursor perform: self cursorSelector
]

{ #category : #initialization }
ToResizeGrip >> target: anElement [

	self layoutIn: anElement.
	self addEventHandler: (ToResizeGripEventHandler new gripTarget: anElement)
]

{ #category : #initialization }
ToResizeGrip >> thickness [

	^ thickness
]

{ #category : #initialization }
ToResizeGrip >> thickness: aNumber [

	thickness := aNumber
]
