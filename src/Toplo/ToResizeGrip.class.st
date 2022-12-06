Class {
	#name : #ToResizeGrip,
	#superclass : #ToElement,
	#traits : 'TToDressableWidget',
	#classTraits : 'TToDressableWidget classTrait',
	#instVars : [
		'initialTargetPosition',
		'initialTargetSize',
		'pulled',
		'thickness'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'mouse processing' }
ToResizeGrip >> applyLayoutIn: anElement [

	"compute my position/size only if I'm not pulled"

	pulled ifTrue: [ ^ self ].
	self layoutIn: anElement
]

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
	pulled := false.
	self layout: BlFrameLayout new.
	self initializeDresser 
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

	self when: BlPullStartEvent do: [ :anEvent | 
		pulled := true.
		self initialTargetPosition: anElement position.
		self initialTargetSize: anElement size ].

	self when: BlPullEvent do: [ :anEvent | 
		self pullEvent: anEvent on: anElement].

	self when: BlPullEndEvent do: [ :anEvent | 
		pulled := false.
		anEvent currentTarget mouseCursor: BlCursor default ].
	
	self when: BlMouseEnterEvent do: [ :event | 
		event currentTarget mouseCursor: event currentTarget cursor ].

	self addEventHandler: self newPullHandler
]

{ #category : #initialization }
ToResizeGrip >> thickness: aNumber [

	thickness := aNumber
]
