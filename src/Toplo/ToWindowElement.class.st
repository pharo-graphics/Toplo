Class {
	#name : #ToWindowElement,
	#superclass : #ToElement,
	#instVars : [
		'root'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToWindowElement >> close [

	"Delegate closing to the Universe"

	self parentDo: [ :p | 
		[ self removeFromParent ]
			on: Error
			do: [ :err | 
				(self class name , '>>close') traceCr.
				err traceCr ] ]
]

{ #category : #initialization }
ToWindowElement >> defaultBorder [

	^ BlBorder empty
]

{ #category : #initialization }
ToWindowElement >> defaultGeometry [ 
	
	^ (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #initialization }
ToWindowElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToWindowElement >> defaultRoot [

	^ ToElement new
		  background: self defaultRootBackground;
		  labeled: self defaultRootLabel;
		  layout: self defaultRootLayout;
		  fitContent
]

{ #category : #initialization }
ToWindowElement >> defaultRootBackground [

	^ Color transparent
]

{ #category : #initialization }
ToWindowElement >> defaultRootLabel [
	^ 'ToWindowElement root'
]

{ #category : #initialization }
ToWindowElement >> defaultRootLayout [

	^ BlLinearLayout vertical 

]

{ #category : #initialization }
ToWindowElement >> elements [

	^ { self root }
]

{ #category : #initialization }
ToWindowElement >> initialize [

	super initialize.
	self
		elevation: (BlRelativeElevation elevation: SmallInteger maxVal);
		border: self defaultBorder;
		layout: self defaultLayout;
		outskirts: BlOutskirts outside;
		geometry: self defaultGeometry;
		fitContent.
	self constraintsDo: [ :c | c ignoreByLayout ].	
	self addChildren: self elements.
]

{ #category : #'api - displaying' }
ToWindowElement >> isClosed [

	^ self isOpened not
]

{ #category : #'api - displaying' }
ToWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #accessing }
ToWindowElement >> root [
	"Return my current root element.
	root can not be nil"
	
	^ root ifNil: [ root := self defaultRoot ]
]

{ #category : #accessing }
ToWindowElement >> root: anElement [

	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"

	root ifNotNil: [ 
		root removeFromParent ].
	root := anElement
]

{ #category : #accessing }
ToWindowElement >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #'api - displaying' }
ToWindowElement >> toFront [

	self detachFromParentWhile: [ 
		self elevation: (BlRelativeElevation elevation: SmallInteger maxVal) ]
]
