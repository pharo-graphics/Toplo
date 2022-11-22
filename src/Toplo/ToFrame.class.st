Class {
	#name : #ToFrame,
	#superclass : #ToWidget,
	#instVars : [
		'bar',
		'root',
		'title',
		'titleLabel'
	],
	#category : #'Toplo-Widget-Frame'
}

{ #category : #'api - adding children' }
ToFrame >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	
	self root addChild: anElement
]

{ #category : #accessing }
ToFrame >> bar [

	^ bar
]

{ #category : #accessing }
ToFrame >> bar: anElement [

	bar ifNotNil: [ 
		bar removeEventHandler: (bar userData at: #pullHandler).
		bar removeFromParent ].
	bar := anElement.
	bar userData at: #pullHandler put: (BlPullHandler new pullTarget: self).
	bar addEventHandler: (bar userData at: #pullHandler).
	self addChild: bar at: 1 as: #bar.
]

{ #category : #'api - displaying' }
ToFrame >> close [

	"Delegate closing work to the Universe"

	self parentDo: [ :p | 
		[ self removeFromParent ]
			on: Error
			do: [ :err | 
				(self class name , '>>close') traceCr.
				err traceCr ] ]
]

{ #category : #initialization }
ToFrame >> defaultBar [

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
	b when: BlMouseDownEvent do: [ self toFront  ].
	close := ToButton new iconImage: Smalltalk ui theme windowCloseForm.
	close whenClickedDo: [ self close ].
	expand := ToButton new iconImage:
		          Smalltalk ui theme windowMaximizeForm.
	expand whenClickedDo: [ self maximize ].

	fill1 := BlElement new
		         background: Color transparent;
		         height: 20;
		         constraintsDo: [ :c | c horizontal matchParent ].
	fill2 := BlElement new
		         background: Color transparent;
		         height: 20;
		         constraintsDo: [ :c | c horizontal matchParent ].

	b addChild: close.
	b addChild: fill1.
	b addChild: (titleLabel := ToLabel new text: self title).
	b addChild: fill2.
	b addChild: expand.

	^ b
]

{ #category : #initialization }
ToFrame >> defaultBarBackground [
	
	^ Color veryLightGray alpha: 0.4
]

{ #category : #initialization }
ToFrame >> defaultBorder [

	^ BlBorder paint: self defaultBorderPaint width: 3
]

{ #category : #initialization }
ToFrame >> defaultBorderPaint [

	^ Color veryLightGray alpha: 0.8
]

{ #category : #initialization }
ToFrame >> defaultGeometry [ 
	
	^ (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #initialization }
ToFrame >> defaultRoot [

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
ToFrame >> defaultRootBackground [

	^ Color white
]

{ #category : #initialization }
ToFrame >> defaultRootLabel [
	^ 'Root element'
]

{ #category : #initialization }
ToFrame >> defaultSize [

	^ 300@200
]

{ #category : #initialization }
ToFrame >> defaultTitle [

	^ ''
]

{ #category : #initialization }
ToFrame >> defaultViewModel [

	^ ToFrameModel new
]

{ #category : #initialization }
ToFrame >> initialize [

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
	self initializeGrips
]

{ #category : #initialization }
ToFrame >> initializeBar [

	self bar: self defaultBar
]

{ #category : #initialization }
ToFrame >> initializeGrip: aGrip [

	aGrip background: Color transparent.
	aGrip border: BlBorder empty.
	aGrip
		when: BlMouseEnterEvent
		do: [ :anEvent | anEvent currentTarget border: (BlBorder paint: self theme button hoveredBorderColor width: 1) ];
		when: BlMouseLeaveEvent
		do: [ :anEvent | 
			anEvent currentTarget border: BlBorder empty ].
	super addChild: aGrip

]

{ #category : #initialization }
ToFrame >> initializeGrips [

	{ 
		ToBottomRightResizeGrip.
		ToBottomLeftResizeGrip.
		ToTopRightResizeGrip.
		ToTopLeftResizeGrip.
		ToRightResizeGrip.
		ToLeftResizeGrip.
		ToBottomResizeGrip.
		ToTopResizeGrip } do: [ :cls | 
		self initializeGrip: (cls new target: self) ]
]

{ #category : #initialization }
ToFrame >> initializeRoot [

	self root: self defaultRoot
]

{ #category : #'api - displaying' }
ToFrame >> maximize [

	self
		relocate: 0 @ 0;
		size: self parent size
]

{ #category : #'api - adding children' }
ToFrame >> removeChild: anElement [
	"Remove a given element from the space root"
	
	self root removeChild: anElement
]

{ #category : #accessing }
ToFrame >> root [
	"Return my current root element.
	root can not be nil"
	
	^ root
]

{ #category : #accessing }
ToFrame >> root: anElement [

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
ToFrame >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #'api - displaying' }
ToFrame >> show [
	"Open me in a window and show it to the user"

	self openInOBlSpace
]

{ #category : #accessing }
ToFrame >> title [

	^ title
]

{ #category : #accessing }
ToFrame >> title: aString [

	title := aString.
	titleLabel ifNotNil: [ titleLabel text: aString ]
]

{ #category : #'api - displaying' }
ToFrame >> toFront [

	self parentDo: [ :p | 
		| focused |
		focused := self deepestFocusedChild.
		focused traceCr.
		p detachChild: self.
		self elevation: (BlRelativeElevation elevation: 10000).
		p attachChild: self.
		focused ifNotNil: [ focused requestFocus ] ]
]
