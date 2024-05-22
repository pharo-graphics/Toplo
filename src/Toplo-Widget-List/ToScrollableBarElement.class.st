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
		aBlock value: node value: node holder position ]
]
