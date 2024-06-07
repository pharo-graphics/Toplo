Class {
	#name : #ToIncWindowElement,
	#superclass : #ToElement,
	#instVars : [
		'wspace',
		'rootElement'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #accessing }
ToIncWindowElement >> borderless: aBoolean [

	wspace borderless: aBoolean
]

{ #category : #'api - displaying' }
ToIncWindowElement >> close [

	wspace close
]

{ #category : #initialization }
ToIncWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 1000)
]

{ #category : #initialization }
ToIncWindowElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToIncWindowElement >> defaultRootElement [

	^ ToElement new
		  id: self defaultRootId;
		  layout: self defaultRootLayout;
		  matchParent
]

{ #category : #initialization }
ToIncWindowElement >> defaultRootId [

	^ 'window-root'
]

{ #category : #initialization }
ToIncWindowElement >> defaultRootLayout [

	^ BlBasicLayout new

]

{ #category : #initialization }
ToIncWindowElement >> initialize [

	super initialize.
	self
		elevation: self defaultElevation;
		layout: self defaultLayout;
		fitContent.
	self constraintsDo: [ :c | c ignoreByLayout ].	
	rootElement := self defaultRootElement.
	self addChild: rootElement.
	self initializeRootElement.
	self matchParent.
	wspace := BlSpace new
]

{ #category : #initialization }
ToIncWindowElement >> initializeRootElement [


]

{ #category : #skin }
ToIncWindowElement >> installRawStyle [

	super installRawStyle.
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self valueOfTokenNamed: #'border-radius-SM')).
	self border: (self valueOfTokenNamed: #'color-border').
	self background: Color red"(self valueOfTokenNamed: #'color-bg-container')".
	self outskirts: BlOutskirts outside 
]

{ #category : #'api - displaying' }
ToIncWindowElement >> isClosed [

	^ self isOpened not
]

{ #category : #'api - displaying' }
ToIncWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #'api - displaying' }
ToIncWindowElement >> open [

"	self useMorphicHost ifTrue: [
		self anchorRoot addChild: self.
		^ self ]."

	wspace root addChild: self.
	wspace show
]

{ #category : #'api - bounds' }
ToIncWindowElement >> position: aPoint [

	super position: 0@0.
	wspace position: aPoint
]

{ #category : #accessing }
ToIncWindowElement >> resizable: aBoolean [

	wspace resizable: aBoolean
]

{ #category : #accessing }
ToIncWindowElement >> root [
	"Return my current root element.
	root can not be nil"
	
	^ rootElement
]

{ #category : #accessing }
ToIncWindowElement >> root: anElement [

	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"

	rootElement ifNotNil: [ 
		rootElement removeFromParent ].
	rootElement := anElement
]

{ #category : #initialization }
ToIncWindowElement >> rootLayout [

	^ self root layout

]

{ #category : #initialization }
ToIncWindowElement >> rootLayout: aLayout [

	self root layout: aLayout

]

{ #category : #'api - bounds' }
ToIncWindowElement >> size: aPoint [

	"super position: 0@0."
	wspace extent: aPoint
]

{ #category : #'api - displaying' }
ToIncWindowElement >> toFront [

	self elevation: self defaultElevation.
	self root elevation: self defaultElevation
]

{ #category : #accessing }
ToIncWindowElement >> wspace [

	^ wspace
]

{ #category : #accessing }
ToIncWindowElement >> wspace: aSpace [

	wspace := aSpace
]
