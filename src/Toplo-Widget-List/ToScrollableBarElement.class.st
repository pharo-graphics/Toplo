Class {
	#name : #ToScrollableBarElement,
	#superclass : #ToScrollableElement,
	#instVars : [
		'trackElement',
		'fakeNode',
		'nodeScrolling',
		'nodeWrapping',
		'nodeAutoDistribution',
		'horizontal'
	],
	#category : #'Toplo-Widget-List-InnerLinearBar'
}

{ #category : #'instance creation' }
ToScrollableBarElement class >> onLinearBarElement: aLinearBarElement [

	^ self basicNew
		  parentBarElement: aLinearBarElement;
		  initialize
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> addAllHolders: anArray at: aPosition [

	anArray reverseDo: [ :h | self addHolder: h at: aPosition]
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> addHolder: anHolder at: aPosition [

	| node |
	node := anHolder node.
	trackElement addChild: node at: aPosition
]

{ #category : #initialization }
ToScrollableBarElement >> configureLayoutIn: aListElement [

	nodeScrolling := aListElement nodeScrolling.
	nodeWrapping := aListElement nodeWrapping.
	nodeAutoDistribution := aListElement nodeAutoDistribution.
	horizontal := aListElement isHorizontal.

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
					 ifTrue: [ BlFlowLayout horizontal ]
					 ifFalse: [ BlLinearLayout horizontal ]).
			trackElement constraintsDo: [ :c |
				c vertical fitContent.
				self isNodeScrolling
					ifTrue: [ c horizontal fitContent ]
					ifFalse: [ c horizontal matchParent ] ] ]
		ifFalse: [
			trackElement layout: (self isNodeWrapping
					 ifTrue: [ BlFlowLayout vertical ]
					 ifFalse: [ BlLinearLayout vertical ]).
			trackElement constraintsDo: [ :c |
				c horizontal fitContent.
				self isNodeScrolling
					ifTrue: [ c vertical fitContent ]
					ifFalse: [ c vertical matchParent ] ] ].

	self isNodeScrolling ifFalse: [
		self isNodeAutoDistribution ifTrue: [
			self nodesDo: [ :n | n autoDistribute ] ] ]
]

{ #category : #accessing }
ToScrollableBarElement >> fakeNode: aNode [

	fakeNode := aNode
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
