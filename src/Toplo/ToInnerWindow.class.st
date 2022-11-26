Class {
	#name : #ToInnerWindow,
	#superclass : #BlElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'bar',
		'root',
		'title',
		'titleLabel',
		'grips'
	],
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #'api - adding children' }
ToInnerWindow >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	
	self root addChild: anElement
]

{ #category : #accessing }
ToInnerWindow >> bar [

	^ bar
]

{ #category : #accessing }
ToInnerWindow >> bar: anElement [

	bar ifNotNil: [ 
		bar removeEventHandler: (bar userData at: #pullHandler).
		bar removeFromParent ].
	bar := anElement.
	bar userData at: #pullHandler put: (BlPullHandler new pullTarget: self).
	bar addEventHandler: (bar userData at: #pullHandler).
	self addChild: bar at: 1 as: #bar.
]

{ #category : #'api - displaying' }
ToInnerWindow >> close [

	"Delegate closing work to the Universe"

	self parentDo: [ :p | 
		[ self removeFromParent ]
			on: Error
			do: [ :err | 
				(self class name , '>>close') traceCr.
				err traceCr ] ]
]

{ #category : #initialization }
ToInnerWindow >> defaultBar [

	| b close expand fill1 fill2 |
	b := BlElement new
		     margin: (BlInsets all: 1);
		     border: self defaultBorder;
		     outskirts: BlOutskirts outside;
		     background: self defaultBarBackground;
		     constraintsDo: [ :c | 
			     c vertical fitContent.
			     c horizontal matchParent ].

	b layout: (BlGridLayout horizontal cellSpacing: 1).

	b when: BlDoubleClickEvent do: [ self maximize ].
	b when: BlMouseDownEvent do: [ self toFront ].
	close := ToButton new iconImage: Smalltalk ui theme windowCloseForm.
	close whenClickedDo: [ self close ].
	expand := ToButton new iconImage: Smalltalk ui theme windowMaximizeForm.
	expand whenClickedDo: [ self maximize ].

	fill1 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c | 
			         c vertical matchParent.
			         c horizontal matchParent ].
	fill2 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c | 
			         c vertical matchParent.
			         c horizontal matchParent ].
	titleLabel := ToLabel new text: self title.
	
	b addChildren: { 
			close.
			fill1.
			titleLabel.
			fill2.
			expand }.

	^ b
]

{ #category : #initialization }
ToInnerWindow >> defaultBarBackground [
	
	^ Color veryLightGray alpha: 0.4
]

{ #category : #initialization }
ToInnerWindow >> defaultBorder [

	^ BlBorder paint: self defaultBorderPaint width: self defaultBorderWidth
]

{ #category : #initialization }
ToInnerWindow >> defaultBorderPaint [

	^ Color veryLightGray alpha: 0.8
]

{ #category : #initialization }
ToInnerWindow >> defaultBorderWidth [

	^ 3
]

{ #category : #initialization }
ToInnerWindow >> defaultGeometry [ 
	
	^ (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #initialization }
ToInnerWindow >> defaultRoot [

	^ BlElement new
		  background: self defaultRootBackground;
		  labeled: self defaultRootLabel;
		  border: self defaultBorder;
		  margin: (BlInsets all: 1);
		  outskirts: BlOutskirts outside;
		  constraintsDo: [ :c | 
			  c vertical matchParent.
			  c horizontal matchParent ]
]

{ #category : #initialization }
ToInnerWindow >> defaultRootBackground [

	^ Color white
]

{ #category : #initialization }
ToInnerWindow >> defaultRootLabel [
	^ 'Frame root'
]

{ #category : #initialization }
ToInnerWindow >> defaultSize [

	^ 300@200
]

{ #category : #initialization }
ToInnerWindow >> defaultTitle [

	^ ''
]

{ #category : #initialization }
ToInnerWindow >> defaultViewModel [

	^ ToInnerWindowModel new
]

{ #category : #initialization }
ToInnerWindow >> initialize [

	super initialize.
	self
		background: (Color white alpha: 0.7);
		size: self defaultSize;
		border: self defaultBorder;
		layout: BlLinearLayout vertical;
		outskirts: BlOutskirts outside;
		geometry: self defaultGeometry;
		clipChildren: false;
		constraintsDo: [ :c | c minWidth: 140 ].
	self title: self defaultTitle.
	self initializeBar.
	self initializeRoot.
	self initializeGrips.
	self dresser: self defaultDresser
]

{ #category : #initialization }
ToInnerWindow >> initializeBar [

	self bar: self defaultBar
]

{ #category : #initialization }
ToInnerWindow >> initializeGrips [

	grips := { 
		ToBottomRightResizeGrip.
		ToBottomLeftResizeGrip.
		ToTopRightResizeGrip.
		ToTopLeftResizeGrip.
		ToRightResizeGrip.
		ToLeftResizeGrip.
		ToBottomResizeGrip.
		ToTopResizeGrip } collect: [ :cls | cls new target: self ].
		
	self addChildren: grips.
	
	self
		when: BlElementExtentChangedEvent
		do: [ :evt | self layoutGrips ].


]

{ #category : #initialization }
ToInnerWindow >> initializeRoot [

	self root: self defaultRoot
]

{ #category : #spec2 }
ToInnerWindow >> inspectionPreview: aBuilder [
	"<inspectorPresentationOrder: 1 title: 'Preview'>"

	^ self root inspectionPreview: aBuilder
]

{ #category : #spec2 }
ToInnerWindow >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Tree'>

	^ self root inspectionTree: aBuilder
]

{ #category : #'grips managing' }
ToInnerWindow >> layoutGrips [

	grips	do: [ :g | g applyLayoutIn: self ]
]

{ #category : #'api - displaying' }
ToInnerWindow >> maximize [

	self
		relocate: 0 @ 0;
		size: self parent size
]

{ #category : #'api - adding children' }
ToInnerWindow >> removeChild: anElement [
	"Remove a given element from the space root"
	
	self root removeChild: anElement
]

{ #category : #accessing }
ToInnerWindow >> root [
	"Return my current root element.
	root can not be nil"
	
	^ root
]

{ #category : #accessing }
ToInnerWindow >> root: anElement [

	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"

	root ifNotNil: [ 
		"root removeEventHandler: (root userData at: #pullHandler)."
		root removeFromParent ].
	root := anElement.
	"root userData at: #pullHandler put: BlPullHandler new.
	root addEventHandler: (root userData at: #pullHandler)."
	anElement constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].

	self addChild: root at: 2 as: #root
]

{ #category : #accessing }
ToInnerWindow >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #'api - displaying' }
ToInnerWindow >> show [
	"Open me in a window and show it to the user"

	self openInOBlSpace
]

{ #category : #accessing }
ToInnerWindow >> title [

	^ title
]

{ #category : #accessing }
ToInnerWindow >> title: aString [

	title := aString.
	titleLabel ifNotNil: [ titleLabel text: aString ]
]

{ #category : #'api - displaying' }
ToInnerWindow >> toFront [

	self detachFromParentWhile: [ 
		self elevation: (BlRelativeElevation elevation: SmallInteger maxVal) ]
]
