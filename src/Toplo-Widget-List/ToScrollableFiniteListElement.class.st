Class {
	#name : #ToScrollableFiniteListElement,
	#superclass : #ToScrollableElement,
	#traits : 'TToInnerListElement + TToInnerFiniteListElement',
	#classTraits : 'TToInnerListElement classTrait + TToInnerFiniteListElement classTrait',
	#instVars : [
		'trackElement'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'t - inner finite list element - requirements' }
ToScrollableFiniteListElement >> addNodeContainer: aNodeContainer at: aPosition [

	trackElement addChild: aNodeContainer at: aPosition
]

{ #category : #configuration }
ToScrollableFiniteListElement >> applyConfiguration [

	super applyConfiguration.
	self applyInnerFiniteListElementConfiguration
]

{ #category : #accessing }
ToScrollableFiniteListElement >> cleanUpRecyclerAt: anIndex [
]

{ #category : #initialization }
ToScrollableFiniteListElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ ToListScrollFlinger
]

{ #category : #initialization }
ToScrollableFiniteListElement >> initialize [

	super initialize.
	self initializeAsToInnerFiniteElement.
	self trackElement: self trackElementClass new.

]

{ #category : #'t - inner list element' }
ToScrollableFiniteListElement >> isOrientable [

	^ true
]

{ #category : #'t - inner list element - requirements' }
ToScrollableFiniteListElement >> nodeContainers [

	^ trackElement nodeContainers
]

{ #category : #'t - inner list element - requirements' }
ToScrollableFiniteListElement >> nodeContainersDo: aBlock [

	trackElement nodeContainersDo: aBlock
]

{ #category : #'hooks - layout' }
ToScrollableFiniteListElement >> onEnterLayoutOrScroll [
]

{ #category : #'hooks - layout' }
ToScrollableFiniteListElement >> onExitLayoutOrScroll [


]

{ #category : #'hooks - layout' }
ToScrollableFiniteListElement >> onLayoutDone [

	super onLayoutDone.
	self consumeFinalStepCommands
]

{ #category : #'t - inner list element - requirements' }
ToScrollableFiniteListElement >> partlyVisibleNodesDo: aBlock [

	trackElement partlyVisibleNodesDo: aBlock
]

{ #category : #'hooks - layout' }
ToScrollableFiniteListElement >> prefetchingAllowed [

	^ false
]

{ #category : #'t - inner finite list element - accessing nodes' }
ToScrollableFiniteListElement >> removeAllNodeContainers: anArray [

	anArray reverseDo: [ :container | 
		trackElement removeNodeContainer: container.
		self notifyChildDetached: container  ]
]

{ #category : #'t - inner finite list element - requirements' }
ToScrollableFiniteListElement >> removeNodeContainer: aNode [

	trackElement removeNodeContainer: aNode 
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> scrollDeltaFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeContainerAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInListElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> scrollDeltaTowardEndFromDataSourcePosition: anIndex [

	| node bnds offset padding |
	node := self nodeContainerAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInListElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	padding := listElement padding.
	offset := listElement isHorizontal
		          ifTrue: [ padding right - listElement width + bnds width ]
		          ifFalse: [
		          padding bottom - listElement height + bnds height ].
	^ bnds position + offset
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> scrollDeltaTowardStartFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeContainerAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInListElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> scrollToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> scrollTowardEndToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> scrollTowardStartToDataSourcePosition: anIndex [

	(self scrollDeltaTowardStartFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> smoothScrollBy: aPoint [
	"Animate a scroll by the given amount of pixels along either axis"
	| dX dY aContent |

	self hasScrolledElement
		ifFalse: [ ^ self ].

	aContent := self scrolledElement.

	dX := aPoint x.
	dY := aPoint y negated.
	
	self canScrollHorizontally
			ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := self scrollPosition x + dX.
			aMinPosition := (self width - aContent width) min: 0.0.
			aMaxPosition := 0.0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			
			dX := aNewClampedPosition - self scrollPosition x ]
		ifFalse: [ dX := 0.0 ].
	
	self canScrollVertically
		ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := self scrollPosition y + dY.
			aMinPosition := (self height - aContent height) min: 0.0.
			aMaxPosition := 0.0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			dY := aNewClampedPosition - self scrollPosition y ]
		ifFalse: [ dY := 0.0 ].
	
	(dX isZero and: [ dY isZero ])
		ifFalse: [ scrollFlinger smoothScrollBy: dX @ dY]
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> smoothScrollToDataSourcePosition: anIndex [

	(self scrollDeltaFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self smoothScrollBy: p x negated @ p y ]
]

{ #category : #'t - inner finite list element - scrolling requirements' }
ToScrollableFiniteListElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"
		
	self stopScrollersInternal
]

{ #category : #scrolling }
ToScrollableFiniteListElement >> stopScrollersInternal [ 

	scrollFlinger stop
]

{ #category : #accessing }
ToScrollableFiniteListElement >> trackElement [
	" introduced for tests, should be used privately "
	^ trackElement 
]

{ #category : #accessing }
ToScrollableFiniteListElement >> trackElement: anElement [

	trackElement ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].
	trackElement := anElement.
	trackElement id: #track.
	trackElement onListElement: listElement .
	self addChild: trackElement 
]

{ #category : #initialization }
ToScrollableFiniteListElement >> trackElementClass [

	^ ToScrollableFiniteListTrackElement 
]
