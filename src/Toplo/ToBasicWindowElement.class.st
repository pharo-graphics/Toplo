Class {
	#name : #ToBasicWindowElement,
	#superclass : #ToElement,
	#instVars : [
		'wspace',
		'rootElement'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToBasicWindowElement >> close [

	self removeFromParent
]

{ #category : #initialization }
ToBasicWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 1000)
]

{ #category : #initialization }
ToBasicWindowElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToBasicWindowElement >> defaultRootElement [

	^ ToElement new
		  id: self defaultRootId;
		  layout: self defaultRootLayout;
		  fitContent
]

{ #category : #initialization }
ToBasicWindowElement >> defaultRootId [

	^ 'window-root'
]

{ #category : #initialization }
ToBasicWindowElement >> defaultRootLayout [

	^ BlLinearLayout vertical 

]

{ #category : #initialization }
ToBasicWindowElement >> initialize [

	super initialize.
	self
		elevation: self defaultElevation;
		layout: self defaultLayout;
		fitContent.
	self constraintsDo: [ :c | c ignoreByLayout ].	
	rootElement := self defaultRootElement.
	self addChild: rootElement.
	self initializeRootElement 
]

{ #category : #initialization }
ToBasicWindowElement >> initializeRootElement [


]

{ #category : #skin }
ToBasicWindowElement >> installRawStyle [

	super installRawStyle.
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self valueOfTokenNamed: #'border-radius-SM')).
	self border: (self valueOfTokenNamed: #'color-border').
	self background: (self valueOfTokenNamed: #'color-bg-container').
	self outskirts: BlOutskirts outside 
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> isClosed [

	^ self isOpened not
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #accessing }
ToBasicWindowElement >> root [
	"Return my current root element.
	root can not be nil"
	
	^ rootElement
]

{ #category : #accessing }
ToBasicWindowElement >> root: anElement [

	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"

	rootElement ifNotNil: [ 
		rootElement removeFromParent ].
	rootElement := anElement
]

{ #category : #initialization }
ToBasicWindowElement >> rootLayout [

	^ self root layout

]

{ #category : #initialization }
ToBasicWindowElement >> rootLayout: aLayout [

	self root layout: aLayout

]

{ #category : #'api - displaying' }
ToBasicWindowElement >> toFront [

	self elevation: self defaultElevation.
	self root elevation: self defaultElevation
]
