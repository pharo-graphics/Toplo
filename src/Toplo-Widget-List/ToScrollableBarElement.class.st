Class {
	#name : #ToScrollableBarElement,
	#superclass : #ToScrollableElement,
	#instVars : [
		'trackElement',
		'nodeScrolling',
		'nodeWrapping',
		'nodeAutoDistribution',
		'flowLineUniformWidth',
		'horizontal',
		'fakeNode'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'accessing - children' }
ToScrollableBarElement >> addAllHolders: anArray at: aPosition [

	anArray reverseDo: [ :h | self addHolder: h at: aPosition]
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> addFakeNode: aNode [

	fakeNode ifNotNil: [ fakeNode removeFromParent ].
	fakeNode := aNode.
	trackElement addChild: aNode at: 1
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> addHolder: anHolder at: aPosition [

	| node |
	node := anHolder node.
	trackElement addChild: node at: aPosition + 1
]

{ #category : #initialization }
ToScrollableBarElement >> configureLayoutIn: aListElement [

	nodeScrolling := aListElement nodeScrolling.
	nodeWrapping := aListElement nodeWrapping.
	nodeAutoDistribution := aListElement nodeAutoDistribution.
	horizontal := aListElement isHorizontal.
	flowLineUniformWidth := aListElement flowLineUniformWidth.

	self isHorizontal
		ifTrue: [
			self constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal matchParent ] ]
		ifFalse: [
			self constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical matchParent ] ].

	self isHorizontal
		ifTrue: [ 
			trackElement layout: (self isNodeWrapping
					 ifTrue: [
						 BlFlowLayout horizontal
							 lineUniformWidth: self isFlowLineUniformWidth;
							 yourself ]
					 ifFalse: [ BlLinearLayout horizontal ]).
			trackElement constraintsDo: [ :c |
				c vertical fitContent.
				self isNodeScrolling
					ifTrue: [ c horizontal fitContent ]
					ifFalse: [ c horizontal matchParent ] ] ]
		ifFalse: [
			trackElement layout: (self isNodeWrapping
					 ifTrue: [
						 BlFlowLayout vertical
							 lineUniformWidth: self isFlowLineUniformWidth;
							 yourself ]
					 ifFalse: [ BlLinearLayout vertical ]).
			trackElement constraintsDo: [ :c |
				c horizontal fitContent.
				self isNodeScrolling
					ifTrue: [ c vertical fitContent ]
					ifFalse: [ c vertical matchParent ] ] ].

	self isNodeScrolling ifFalse: [
		self nodesDo: [ :n | n autoDistribute: self isNodeAutoDistribution ] ]
]

{ #category : #'private - commands' }
ToScrollableBarElement >> consumePendingDataSourceCommands [
]

{ #category : #initialization }
ToScrollableBarElement >> defaultEventHandler [ 

	^ ToScrollableElementEventHandler new
	"^ BlScrollableElementEventHandler new"
]

{ #category : #initialization }
ToScrollableBarElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> fullyVisibleNodesDo: aBlock [

	self nodesDo: [ :node |
		node isFullyVisible ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> fullyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  node isFullyVisible ifTrue: [
				  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ] ]
]

{ #category : #initialization }
ToScrollableBarElement >> initialize [ 

	super initialize.
	trackElement := ToElement new.
	trackElement id: #track.
	self addChild: trackElement.
	self matchParent
]

{ #category : #testing }
ToScrollableBarElement >> isFlowLineUniformWidth [

	^ flowLineUniformWidth 
]

{ #category : #testing }
ToScrollableBarElement >> isHorizontal [

	^ horizontal
]

{ #category : #testing }
ToScrollableBarElement >> isNodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #testing }
ToScrollableBarElement >> isNodeScrolling [

	^ nodeScrolling
]

{ #category : #testing }
ToScrollableBarElement >> isNodeWrapping [

	^ nodeWrapping
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodes [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node | stream nextPut: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodesDo: aBlock [

	trackElement childrenDo: [ :node |
		node = fakeNode ifFalse: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodesWithIndexDo: aBlock [

	self nodesDo: [ :node |
		aBlock value: node value: node holder position]
]

{ #category : #'hooks - layout' }
ToScrollableBarElement >> onEnterLayoutOrScroll [
]

{ #category : #'hooks - layout' }
ToScrollableBarElement >> onExitLayoutOrScroll [
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> partlyVisibleNodesDo: aBlock [

	self nodesDo: [ :node |
		node isPartlyVisible ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> partlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #'hooks - layout' }
ToScrollableBarElement >> prefetchingAllowed [

	^ false
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> removeAllNodes: anArray [

	anArray reverseDo: [ :node | self removeNode: node ]
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> removeNode: aNode [

	aNode
		release;
		removeFromParent
]

{ #category : #'hooks - layout' }
ToScrollableBarElement >> repositionShadowingElements [
]

{ #category : #scrolling }
ToScrollableBarElement >> smoothScrollBy: aPoint [
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
