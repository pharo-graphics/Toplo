Class {
	#name : 'ToBasicWindowElement',
	#superclass : 'ToElement',
	#instVars : [
		'rootElement'
	],
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'api - displaying' }
ToBasicWindowElement >> close [

	self isOpened ifFalse: [ ^ self ].
	self removeFromParent
]

{ #category : 'accessing' }
ToBasicWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 1000)
]

{ #category : 'initialization' }
ToBasicWindowElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : 'initialization' }
ToBasicWindowElement >> defaultRootElement [

	^ ToElement new
		  id: self defaultRootId;
		  layout: self defaultRootLayout;
		  fitContent
]

{ #category : 'initialization' }
ToBasicWindowElement >> defaultRootId [

	^ 'windowElement-root'
]

{ #category : 'initialization' }
ToBasicWindowElement >> defaultRootLayout [

	^ BlLinearLayout vertical 

]

{ #category : 'initialization' }
ToBasicWindowElement >> initialize [

	super initialize.
	self
		elevation: self defaultElevation;
		layout: self defaultLayout;
		fitContent.
	self constraintsDo: [ :c | c ignoreByLayout ].	
	self initializeRootElement 
]

{ #category : 'initialization' }
ToBasicWindowElement >> initializeRootElement [

	rootElement := self defaultRootElement.
	self addChild: rootElement
]

{ #category : 'skin' }
ToBasicWindowElement >> installRawStyle [

	super installRawStyle.
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self tokenValueNamed: #'border-radius-SM')).
	self border: (self tokenValueNamed: #'color-border').
	self background: (self tokenValueNamed: #'color-bg-container')
]

{ #category : 'api - displaying' }
ToBasicWindowElement >> isClosed [

	^ self isOpened not
]

{ #category : 'api - displaying' }
ToBasicWindowElement >> isOpened [

	^ self hasParent
]

{ #category : 'accessing' }
ToBasicWindowElement >> root [
	"Return my current root element.
	root can not be nil"
	
	^ rootElement
]

{ #category : 'accessing' }
ToBasicWindowElement >> root: anElement [

	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"

	rootElement ifNotNil: [ 
		rootElement removeFromParent ].
	rootElement := anElement
]

{ #category : 'accessing' }
ToBasicWindowElement >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : 'initialization' }
ToBasicWindowElement >> rootLayout [

	^ self root layout

]

{ #category : 'initialization' }
ToBasicWindowElement >> rootLayout: aLayout [

	self root layout: aLayout

]

{ #category : 'api - displaying' }
ToBasicWindowElement >> toFront [

	self elevation: self defaultElevation.
	self root elevation: self defaultElevation
]
