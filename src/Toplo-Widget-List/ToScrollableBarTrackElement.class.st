Class {
	#name : #ToScrollableBarTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeNode',
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #adding }
ToScrollableBarTrackElement >> addFakeNode: aNode [

	fakeNode ifNotNil: [ self removeFakeNode ].
	fakeNode := aNode.
	self addChild: aNode at: 1.

]

{ #category : #adding }
ToScrollableBarTrackElement >> addHolder: anHolder at: aPosition [

	| node |
	node := anHolder node.
	self addChild: node at: aPosition + 1
]

{ #category : #layout }
ToScrollableBarTrackElement >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self layout: self newLayoutStrategy.

	listElement isHFitContent
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].

	listElement isVFitContent
		ifTrue: [ self vFitContent ]
		ifFalse: [ self vMatchParent ].

	self autoDistribute
		ifTrue: [
			self isHorizontal
				ifTrue: [
				listElement isHFitContent ifFalse: [ self hMatchParent ] ]
				ifFalse: [
				listElement isVFitContent ifFalse: [ self vMatchParent ] ] ]
		ifFalse: [
			(self isWrapping not and: [ self isScrolling ]) ifTrue: [
				self isHorizontal
					ifTrue: [ self hFitContent ]
					ifFalse: [ self vFitContent ] ] ].

	self constraintFakeNode.
	self nodesDo: [ :n |
		listElement nodeManager applyNodeConstraintsOn: n ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> artlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #testing }
ToScrollableBarTrackElement >> autoDistribute [

	^ listElement autoDistribute
]

{ #category : #layout }
ToScrollableBarTrackElement >> checkFullyVisibleNodes [

	| invisibleNodes visibleNodes |
	self isWrapping ifTrue: [ ^ self ].
	self autoDistribute ifTrue: [ ^ self ].
	invisibleNodes := self nodesSelect: [ :n | 
		n isFullyVisibleInInnerElement not ].
	visibleNodes := self nodes difference: invisibleNodes.
	listElement onInvisibleNodes: invisibleNodes visibleNodes: visibleNodes
]

{ #category : #layout }
ToScrollableBarTrackElement >> constraintFakeNode [
	"fakeNode ifNil: [ listElement installFakeNode ]."

	listElement nodeManager applyFakeNodeConstraintsOn: fakeNode
]

{ #category : #accessing }
ToScrollableBarTrackElement >> fakeNode [ 

	^ fakeNode
]

{ #category : #layout }
ToScrollableBarTrackElement >> flowLayoutClass [

	^ ToBarFlowLayout
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodes [

	^ Array streamContents: [ :stream |
		  self fullyVisibleNodesDo: [ :node | stream nextPut: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodesDo: aBlock [

	self nodesDo: [ :node |
		node isFullyVisibleInInnerElement ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  node isFullyVisibleInInnerElement ifTrue: [
				  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ] ]
]

{ #category : #initialization }
ToScrollableBarTrackElement >> initialize [

	super initialize.
	self focusability: BlFocusability ignore
]

{ #category : #testing }
ToScrollableBarTrackElement >> isHorizontal [

	^ listElement isHorizontal
]

{ #category : #testing }
ToScrollableBarTrackElement >> isScrolling [

	^ listElement isScrolling
]

{ #category : #testing }
ToScrollableBarTrackElement >> isWrapping [

	^ listElement isWrapping
]

{ #category : #layout }
ToScrollableBarTrackElement >> linearLayoutClass [

	^ ToBarLinearLayout
]

{ #category : #accessing }
ToScrollableBarTrackElement >> maxMeasuredNodeSize [

	^ self layout maxMeasuredNodeSize
]

{ #category : #layout }
ToScrollableBarTrackElement >> newFlowLayout [

	^ (self isHorizontal
		   ifTrue: [ self flowLayoutClass horizontal ]
		   ifFalse: [ self flowLayoutClass vertical ])
		  uniformNodeWidth: listElement uniformNodeWidth;
		  uniformNodeHeight: listElement uniformNodeHeight;
		  yourself
]

{ #category : #layout }
ToScrollableBarTrackElement >> newLayoutStrategy [

	^ self isWrapping
		  ifTrue: [ self newFlowLayout ]
		  ifFalse: [ self newLinearLayout ]
]

{ #category : #layout }
ToScrollableBarTrackElement >> newLinearLayout [

	^ (self isHorizontal
		   ifTrue: [ self linearLayoutClass horizontal ]
		   ifFalse: [ self linearLayoutClass vertical ])
		  uniformNodeWidth: listElement uniformNodeWidth;
		  uniformNodeHeight: listElement uniformNodeHeight;
		  yourself
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodes [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node | stream nextPut: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesDo: aBlock [

	self childrenDo: [ :node |
		node = fakeNode ifFalse: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesWithIndexDo: aBlock [

	self nodesDo: [ :node |
		aBlock value: node value: node holder position]
]

{ #category : #initialization }
ToScrollableBarTrackElement >> onListElement: aListElement [

	listElement := aListElement 
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesDo: aBlock [

	self nodesDo: [ :node |
		node isPartlyVisible ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #removing }
ToScrollableBarTrackElement >> removeAllNodes: anArray [

	anArray reverseDo: [ :node | self removeNode: node ]
]

{ #category : #removing }
ToScrollableBarTrackElement >> removeFakeNode [

	fakeNode ifNotNil: [ fakeNode removeFromParent ].
	fakeNode := nil
]

{ #category : #removing }
ToScrollableBarTrackElement >> removeNode: aNode [

	aNode removeFromParent
]
