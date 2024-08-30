Class {
	#name : #ToScrollableBarElement,
	#superclass : #ToScrollableElement,
	#instVars : [
		'trackElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'instance creation' }
ToScrollableBarElement class >> onInnerBarElement: anInnerBarElement [

	^ self new
		  onInnerBarElement: anInnerBarElement;
		  yourself
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> addAllHolders: anArray at: aPosition [

	trackElement addAllHolders: anArray at: aPosition
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> addFakeNode: aNode [

	trackElement addFakeNode: aNode
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> addHolder: anHolder at: aPosition [

	trackElement addHolder: anHolder at: aPosition
]

{ #category : #layout }
ToScrollableBarElement >> configureLayoutIn: aBarElement [

	self matchParent.
	aBarElement isHMatchParent ifFalse: [ self hFitContent ].
	aBarElement isVMatchParent ifFalse: [ self vFitContent ].
	trackElement configureLayoutIn: aBarElement
]

{ #category : #'private - commands' }
ToScrollableBarElement >> consumePendingDataSourceCommands [
]

{ #category : #initialization }
ToScrollableBarElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #'t - infinite scrolled event' }
ToScrollableBarElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'t - infinite scrolled event' }
ToScrollableBarElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent
]

{ #category : #accessing }
ToScrollableBarElement >> fakeNode [ 

	^ trackElement fakeNode
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> fullyVisibleNodes [

	^ trackElement fullyVisibleNodes
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> fullyVisibleNodesDo: aBlock [

	trackElement fullyVisibleNodesDo: aBlock
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> fullyVisibleNodesSelect: aBlock [

	^ trackElement fullyVisibleNodesSelect: aBlock
]

{ #category : #initialization }
ToScrollableBarElement >> initialize [ 

	super initialize.
	self matchParent.

]

{ #category : #testing }
ToScrollableBarElement >> isHorizontal [

	^ trackElement isHorizontal 
]

{ #category : #testing }
ToScrollableBarElement >> isNodeAutoDistribution [

	^ trackElement isNodeAutoDistribution
]

{ #category : #testing }
ToScrollableBarElement >> isNodeScrolling [

	^ trackElement isNodeScrolling
]

{ #category : #testing }
ToScrollableBarElement >> isNodeWrapping [

	^ trackElement isNodeWrapping
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodes [

	^ trackElement nodes
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodesDo: aBlock [

	trackElement nodesDo: aBlock
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodesSelect: aBlock [

	^ trackElement nodesSelect: aBlock 
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodesWithIndexDo: aBlock [

	trackElement nodesWithIndexDo: aBlock
]

{ #category : #'hooks - layout' }
ToScrollableBarElement >> onEnterLayoutOrScroll [
]

{ #category : #'hooks - layout' }
ToScrollableBarElement >> onExitLayoutOrScroll [
]

{ #category : #initialization }
ToScrollableBarElement >> onInnerBarElement: anInnerBarElement [

	self addEventHandler: (ToScrollableBarEventHandler new parentBar: anInnerBarElement )
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> partlyVisibleNodesDo: aBlock [

	trackElement partlyVisibleNodesDo: aBlock
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> partlyVisibleNodesSelect: aBlock [

	^ trackElement partlyVisibleNodesSelect: aBlock
]

{ #category : #'hooks - layout' }
ToScrollableBarElement >> prefetchingAllowed [

	^ false
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> removeAllNodes: anArray [

	trackElement removeAllNodes: anArray
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> removeFakeNode [

	trackElement removeFakeNode
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> removeNode: aNode [

	trackElement removeNode: aNode 
]

{ #category : #initialization }
ToScrollableBarElement >> scrollableBarTrackElementClass [

	^ ToScrollableBarTrackElement 
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

{ #category : #scrolling }
ToScrollableBarElement >> stopScrollersInternal [ 

	scrollFlinger stop
]

{ #category : #accessing }
ToScrollableBarElement >> trackElement [

	^ trackElement 
]

{ #category : #accessing }
ToScrollableBarElement >> trackElement: anElement [

	trackElement = anElement ifTrue: [ ^ self ].
	trackElement := anElement.
	trackElement id: #track
]
