Class {
	#name : #ToScrollableBarTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'nodeScrolling',
		'nodeWrapping',
		'nodeAutoDistribution',
		'horizontal',
		'flowLineUniformWidth',
		'fakeNode'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #adding }
ToScrollableBarTrackElement >> addAllHolders: anArray at: aPosition [

	anArray reverseDo: [ :h | self addHolder: h at: aPosition]
]

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
ToScrollableBarTrackElement >> configureLayoutIn: aBarElement [

	nodeScrolling := aBarElement nodeScrolling.
	nodeWrapping := aBarElement nodeWrapping.
	nodeAutoDistribution := aBarElement nodeAutoDistribution.
	flowLineUniformWidth := aBarElement flowLineUniformWidth.
	self horizontal: aBarElement isHorizontal.

	self layout: self newLayout.

	self matchParent.
	aBarElement isHMatchParent ifFalse: [ self hFitContent ].
	aBarElement isVMatchParent ifFalse: [ self vFitContent ].

	(nodeWrapping not and: [ nodeScrolling ]) ifTrue: [
		self isHorizontal
			ifTrue: [ self hFitContent ]
			ifFalse: [ self vFitContent ] ].

	aBarElement nodeManager constraintFakeNode: fakeNode.
	self nodesDo: [ :n | aBarElement nodeManager constraintNode: n ]
]

{ #category : #accessing }
ToScrollableBarTrackElement >> fakeNode [ 

	^ fakeNode
]

{ #category : #accessing }
ToScrollableBarTrackElement >> flowLineUniformWidth: anObject [

	flowLineUniformWidth := anObject
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
ToScrollableBarTrackElement >> isFlowLineUniformWidth [

	^ flowLineUniformWidth 
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
ToScrollableBarTrackElement >> newLayout [

	^ nodeWrapping
		  ifTrue: [
			  (self isHorizontal
				   ifTrue: [ ToBarFlowLayout horizontal ]
				   ifFalse: [ ToBarFlowLayout vertical ])
				  lineUniformWidth: flowLineUniformWidth;
				  yourself ]
		  ifFalse: [
			  self isHorizontal
				  ifTrue: [ BlLinearLayout horizontal ]
				  ifFalse: [ BlLinearLayout vertical ] ]
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodeAutoDistribution: anObject [

	nodeAutoDistribution := anObject
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodeScrolling: anObject [

	nodeScrolling := anObject
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodeWrapping: anObject [

	nodeWrapping := anObject
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
