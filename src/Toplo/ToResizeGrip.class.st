Class {
	#name : #ToResizeGrip,
	#superclass : #BlElement,
	#instVars : [
		'initialTargetPosition',
		'initialTargetSize'
	],
	#category : #'Toplo-Widget-Root frame'
}

{ #category : #initialization }
ToResizeGrip >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #private }
ToResizeGrip >> disableExtentChangeEventIn: anElement while: aBlock [

	anElement eventDispatcher disableEventType: BlElementExtentChangedEvent.
	aBlock ensure: [ 
		anElement eventDispatcher enableEventType: BlElementExtentChangedEvent ]
]

{ #category : #accessing }
ToResizeGrip >> initialTargetPosition [

	^ initialTargetPosition
]

{ #category : #accessing }
ToResizeGrip >> initialTargetPosition: aPoint [

	initialTargetPosition := aPoint
]

{ #category : #accessing }
ToResizeGrip >> initialTargetSize [

	^ initialTargetSize
]

{ #category : #accessing }
ToResizeGrip >> initialTargetSize: aPoint [

	initialTargetSize := aPoint
]

{ #category : #initialization }
ToResizeGrip >> initialize [

	super initialize.
	self
		size: 10 @ 10;
		background: Color transparent;
		geometry: self defaultGeometry;
		constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : #initialization }
ToResizeGrip >> layoutIn: anElement [

	self subclassResponsibility 
]

{ #category : #initialization }
ToResizeGrip >> newPullHandler [

	^ BlPullHandler new
]

{ #category : #accessing }
ToResizeGrip >> ptName [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToResizeGrip >> pullEvent: anEvent on: anElement [

	self subclassResponsibility 
]

{ #category : #accessing }
ToResizeGrip >> resizeCursor [

	^ Cursor resizeForEdge: self ptName
]

{ #category : #initialization }
ToResizeGrip >> target: anElement [

	self layoutIn: anElement.
	
	anElement
		when: BlElementExtentChangedEvent
		do: [ :evt | self layoutIn: anElement ].

	self when: BlPullStartEvent do: [ :anEvent | 
		self initialTargetPosition: anElement position.
		self initialTargetSize: anElement size ].
	
	self when: BlPullEvent do: [ :anEvent | 
		self
			disableExtentChangeEventIn: anElement
			while: [ self pullEvent: anEvent on: anElement ] ].

	self addEventHandler: self newPullHandler
]
