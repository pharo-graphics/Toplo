Class {
	#name : #ToAbstractWindowElement,
	#superclass : #ToElement,
	#instVars : [
		'rootElement'
	],
	#category : 'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToAbstractWindowElement >> close [

	self parentDo: [ :p | self removeFromParent ]
]

{ #category : #initialization }
ToAbstractWindowElement >> defaultBorder [

	^ BlBorder empty
]

{ #category : #accessing }
ToAbstractWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 1000)
]

{ #category : #initialization }
ToAbstractWindowElement >> defaultGeometry [ 
	
	^ (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #initialization }
ToAbstractWindowElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToAbstractWindowElement >> defaultRootBackground [

	^ Color transparent
]

{ #category : #initialization }
ToAbstractWindowElement >> defaultRootElement [

	^ ToElement new
		  background: self defaultRootBackground;
		  id: self defaultRootId;
		  layout: self defaultRootLayout;
		  fitContent
]

{ #category : #initialization }
ToAbstractWindowElement >> defaultRootId [

	^ 'windowElement-root'
]

{ #category : #initialization }
ToAbstractWindowElement >> defaultRootLayout [

	^ BlLinearLayout vertical 

]

{ #category : #initialization }
ToAbstractWindowElement >> initialize [

	super initialize.
	
	self
		elevation: self defaultElevation;
		border: self defaultBorder;
		background: self defaultBackground;
		layout: self defaultLayout;
		outskirts: BlOutskirts outside;
		geometry: self defaultGeometry;
		fitContent.
	self constraintsDo: [ :c | c ignoreByLayout ].	
	self initializeRootElement 
]

{ #category : #initialization }
ToAbstractWindowElement >> initializeRootElement [

	rootElement := self defaultRootElement.
	self addChild: rootElement
]

{ #category : #'api - displaying' }
ToAbstractWindowElement >> isClosed [

	^ self isOpened not
]

{ #category : #'api - displaying' }
ToAbstractWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #accessing }
ToAbstractWindowElement >> root [
	"Return my current root element.
	root can not be nil"
	
	^ rootElement
]

{ #category : #accessing }
ToAbstractWindowElement >> root: anElement [

	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"

	rootElement ifNotNil: [ 
		rootElement removeFromParent ].
	rootElement := anElement
]

{ #category : #accessing }
ToAbstractWindowElement >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #initialization }
ToAbstractWindowElement >> rootLayout [

	^ self root layout

]

{ #category : #initialization }
ToAbstractWindowElement >> rootLayout: aLayout [

	self root layout: aLayout

]

{ #category : #'api - displaying' }
ToAbstractWindowElement >> toFront [

	self elevation: self defaultElevation
]
