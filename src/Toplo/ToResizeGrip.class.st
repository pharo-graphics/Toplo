Class {
	#name : #ToResizeGrip,
	#superclass : #ToElement,
	#instVars : [
		'initialTargetPosition',
		'initialTargetSize',
		'thickness',
		'initialDragPosition'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToResizeGrip >> cursor [

	^ BlCursor perform: self cursorSelector
]

{ #category : #accessing }
ToResizeGrip >> cursorSelector [

	^ self subclassResponsibility 
]

{ #category : #'t - initialization dresser' }
ToResizeGrip >> defaultDresser [

	^ ToResizeGripDresser new
]

{ #category : #'mouse processing' }
ToResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	self subclassResponsibility 
]

{ #category : #accessing }
ToResizeGrip >> initialTargetPosition [

	^ initialTargetPosition
]

{ #category : #accessing }
ToResizeGrip >> initialTargetSize [

	^ initialTargetSize
]

{ #category : #initialization }
ToResizeGrip >> initialize [

	super initialize.
	
	self layout: BlFrameLayout new
]

{ #category : #'mouse processing' }
ToResizeGrip >> layoutIn: anElement [

	self subclassResponsibility 
]

{ #category : #initialization }
ToResizeGrip >> target: anElement [

	self layoutIn: anElement.

	self when: BlDragStartEvent do: [ :anEvent | 
		anEvent consumed: true.
		initialDragPosition := anEvent position.
		initialTargetPosition := anElement position.
		initialTargetSize := anElement size ].

	self when: BlDragEvent do: [ :anEvent |
		anEvent consumed: true.
		self drag: anElement by: anEvent position - initialDragPosition ].

	self when: BlDragEndEvent do: [ :anEvent | 
		anEvent consumed: true.
		anEvent currentTarget mouseCursor: BlCursor default ].
	
	self when: BlMouseEnterEvent do: [ :anEvent | 
		anEvent currentTarget mouseCursor: anEvent currentTarget cursor ].

]

{ #category : #initialization }
ToResizeGrip >> thickness [

	^ thickness
]

{ #category : #initialization }
ToResizeGrip >> thickness: aNumber [

	thickness := aNumber
]
