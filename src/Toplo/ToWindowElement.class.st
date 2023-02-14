Class {
	#name : #ToWindowElement,
	#superclass : #ToElement,
	#instVars : [
		'root'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - adding children' }
ToWindowElement >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	self
		deprecated: 'Send addChild: to root.'
		transformWith:
			'`@receiver addChild: `@arg'
				-> '`@receiver root addChild: `@arg'.

	self root addChild: anElement
]

{ #category : #'api - displaying' }
ToWindowElement >> close [

	"Delegate closing work to the Universe"

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

	^ BlLinearLayout vertical
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
	^ 'Frame root'
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
		background: (Color white alpha: 0.7);
		elevation: (BlRelativeElevation elevation: SmallInteger maxVal);
		border: self defaultBorder;
		layout: self defaultLayout;
		outskirts: BlOutskirts outside;
		geometry: self defaultGeometry;
		clipChildren: false;
		fitContent.
		
	self addChildren: self elements.
]

{ #category : #spec2 }
ToWindowElement >> inspectionPreview: aBuilder [
	"<inspectorPresentationOrder: 1 title: 'Preview'>"

	^ super inspectionPreview: aBuilder
]

{ #category : #spec2 }
ToWindowElement >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Tree'>

	^ super inspectionTree: aBuilder
]

{ #category : #'api - adding children' }
ToWindowElement >> removeChild: anElement [
	"Remove a given element from the space root"
	self
		deprecated: 'Send removeChild: to root.'
		transformWith:
			'`@receiver removeChild: `@arg'
				-> '`@receiver root removeChild: `@arg'.

	self root removeChild: anElement
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
