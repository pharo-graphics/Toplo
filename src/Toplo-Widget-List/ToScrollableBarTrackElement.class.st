Class {
	#name : #ToScrollableBarTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'nodeScrolling',
		'nodeWrapping',
		'nodeAutoDistribution',
		'horizontal',
		'flowLineUniformWidth',
		'fakeNode',
		'flowLineUniformHeight'
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

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> artlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #layout }
ToScrollableBarTrackElement >> checkFullyVisibleNodesIn: aListElement [

	| invisibleNodes |
	nodeWrapping ifTrue: [ ^ self ].
	nodeScrolling ifTrue: [ ^ self ].
	nodeAutoDistribution ifTrue: [ ^ self ].
	invisibleNodes := self nodesSelect: [ :n | n isFullyVisible not ].
	invisibleNodes ifEmpty: [ ^ self ].
	aListElement haveInvisibleNodes: invisibleNodes
]

{ #category : #layout }
ToScrollableBarTrackElement >> configureLayoutIn: aBarElement [

	nodeScrolling := aBarElement isNodeScrolling.
	nodeWrapping := aBarElement isNodeWrapping.
	nodeAutoDistribution := aBarElement isNodeAutoDistribution.
	flowLineUniformWidth := aBarElement isUniformNodeWidth.
	flowLineUniformHeight := aBarElement isUniformNodeHeight.
	horizontal := aBarElement isHorizontal.

	self layout: (self newLayoutStrategyIn: aBarElement).

	self matchParent.
	aBarElement isHMatchParent ifFalse: [ self hFitContent ].
	aBarElement isVMatchParent ifFalse: [ self vFitContent ].

	(nodeWrapping not and: [ nodeScrolling ]) ifTrue: [
		self isHorizontal
			ifTrue: [ self hFitContent ]
			ifFalse: [ self vFitContent ] ].

	self constraintFakeNodeIn: aBarElement.
	self nodesDo: [ :n | aBarElement nodeManager constraintNode: n ]
]

{ #category : #layout }
ToScrollableBarTrackElement >> constraintFakeNodeIn: aBarElement [

	fakeNode ifNil: [ aBarElement installFakeNode ].
	aBarElement nodeManager constraintFakeNode: fakeNode
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
		node isFullyVisible ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  node isFullyVisible ifTrue: [
				  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ] ]
]

{ #category : #accessing }
ToScrollableBarTrackElement >> horizontal: anObject [ 

	horizontal := anObject
]

{ #category : #initialization }
ToScrollableBarTrackElement >> initialize [

	super initialize.
	self focusability: BlFocusability ignore
]

{ #category : #testing }
ToScrollableBarTrackElement >> isHorizontal [

	^ horizontal
]

{ #category : #testing }
ToScrollableBarTrackElement >> isNodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #testing }
ToScrollableBarTrackElement >> isNodeScrolling [

	^ nodeScrolling
]

{ #category : #testing }
ToScrollableBarTrackElement >> isNodeWrapping [

	^ nodeWrapping
]

{ #category : #layout }
ToScrollableBarTrackElement >> linearLayoutClass [

	^ BlLinearLayout
]

{ #category : #layout }
ToScrollableBarTrackElement >> newLayoutStrategyIn: aBarElement [

	^ nodeWrapping
		  ifTrue: [
			  (horizontal
				   ifTrue: [ self flowLayoutClass horizontal ]
				   ifFalse: [ self flowLayoutClass vertical ])
				  uniformNodeWidth: flowLineUniformWidth;
				  uniformNodeHeight: flowLineUniformHeight;
				  yourself ]
		  ifFalse: [
			  horizontal
				  ifTrue: [ self linearLayoutClass horizontal ]
				  ifFalse: [ self linearLayoutClass vertical ] ]
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
