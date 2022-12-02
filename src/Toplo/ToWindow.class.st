Class {
	#name : #ToWindow,
	#superclass : #ToElement,
	#instVars : [
		'root'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - adding children' }
ToWindow >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	
	self root addChild: anElement
]

{ #category : #'api - displaying' }
ToWindow >> close [

	"Delegate closing work to the Universe"

	self parentDo: [ :p | 
		[ self removeFromParent ]
			on: Error
			do: [ :err | 
				(self class name , '>>close') traceCr.
				err traceCr ] ]
]

{ #category : #initialization }
ToWindow >> defaultBorder [

	^ BlBorder paint: self defaultBorderPaint width: self defaultBorderWidth
]

{ #category : #initialization }
ToWindow >> defaultBorderPaint [

	^ Color veryLightGray alpha: 0.8
]

{ #category : #initialization }
ToWindow >> defaultBorderWidth [

	^ 0
]

{ #category : #initialization }
ToWindow >> defaultGeometry [ 
	
	^ (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #initialization }
ToWindow >> defaultRoot [

	^ ToElement new
		  background: self defaultRootBackground;
		  labeled: self defaultRootLabel;
		  border: self defaultBorder;
		  margin: (BlInsets all: 1);
		  outskirts: BlOutskirts outside;
		  layout: self defaultRootLayout;
		  matchParent
]

{ #category : #initialization }
ToWindow >> defaultRootBackground [

	^ Color white
]

{ #category : #initialization }
ToWindow >> defaultRootLabel [
	^ 'Frame root'
]

{ #category : #initialization }
ToWindow >> defaultRootLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToWindow >> defaultSize [

	^ 300@200
]

{ #category : #initialization }
ToWindow >> elements [

	^ { self root }
]

{ #category : #initialization }
ToWindow >> initialize [

	super initialize.
	self
		background: (Color white alpha: 0.7);
		elevation: (BlRelativeElevation elevation: SmallInteger maxVal);
		size: self defaultSize;
		border: self defaultBorder;
		layout: BlLinearLayout vertical;
		outskirts: BlOutskirts outside;
		geometry: self defaultGeometry;
		clipChildren: false.
		
	self addChildren: self elements.
]

{ #category : #spec2 }
ToWindow >> inspectionPreview: aBuilder [
	"<inspectorPresentationOrder: 1 title: 'Preview'>"

	^ super inspectionPreview: aBuilder
]

{ #category : #spec2 }
ToWindow >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Tree'>

	^ super inspectionTree: aBuilder
]

{ #category : #'api - adding children' }
ToWindow >> removeChild: anElement [
	"Remove a given element from the space root"
	
	self root removeChild: anElement
]

{ #category : #accessing }
ToWindow >> root [
	"Return my current root element.
	root can not be nil"
	
	^ root ifNil: [ root := self defaultRoot ]
]

{ #category : #accessing }
ToWindow >> root: anElement [

	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"

	root ifNotNil: [ 
		root removeFromParent ].
	root := anElement
]

{ #category : #accessing }
ToWindow >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #'api - displaying' }
ToWindow >> toFront [

	self detachFromParentWhile: [ 
		self elevation: (BlRelativeElevation elevation: SmallInteger maxVal) ]
]
