Class {
	#name : #ToResizeGrip,
	#superclass : #BlElement,
	#instVars : [
		'initialTargetPosition',
		'initialTargetSize'
	],
	#category : #'Toplo-Widget-Frame'
}

{ #category : #accessing }
ToResizeGrip >> cursor [

	^ BlCursor perform: self cursorSelector
]

{ #category : #accessing }
ToResizeGrip >> cursorSelector [

	^ self subclassResponsibility 
]

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

{ #category : #'mouse processing' }
ToResizeGrip >> layoutIn: anElement [

	self subclassResponsibility 
]

{ #category : #initialization }
ToResizeGrip >> newPullHandler [

	^ BlPullHandler new
]

{ #category : #'mouse processing' }
ToResizeGrip >> pullEvent: anEvent on: anElement [

	self subclassResponsibility 
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
		self pullEvent: anEvent on: anElement.
		self layoutIn: anElement ].

	self when: BlPullEndEvent do: [ :anEvent | 
		self layoutIn: anElement.
		anEvent currentTarget mouseCursor: BlCursor default ].
	
	self when: BlMouseEnterEvent do: [ :event | 
		event currentTarget mouseCursor: event currentTarget cursor ].

	self addEventHandler: self newPullHandler
]
