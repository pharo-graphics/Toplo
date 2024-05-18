Class {
	#name : #ToScrollableBarElement,
	#superclass : #ToScrollableElement,
	#instVars : [
		'trackElement',
		'fakeNode',
		'fakeDataItem',
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
ToScrollableBarElement >> addHolders: anArray [

	anArray do: [ :h |
		| node |
		node := h node.
		node constraintsDo: [ :c |
			self isHorizontal
				ifTrue: [
					c horizontal matchParent.
					c vertical fitContent ]
				ifFalse: [
					c vertical matchParent.
					c horizontal fitContent ] ].
		trackElement addChild: node ]
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
"				c linear vertical alignCenter.
				c flow vertical alignCenter.
"				c vertical fitContent.
				c horizontal matchParent ] ]
		ifFalse: [
			self constraintsDo: [ :c |
"				c linear horizontal alignCenter.
				c flow horizontal alignCenter.
"				c horizontal fitContent.
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
			self nodesDo: [ :n | n autoDistribute ] ] ].
	
	"self installFakeNode"
]

{ #category : #initialization }
ToScrollableBarElement >> initialize [ 

	super initialize.
	trackElement := ToElement new.
	trackElement id: #track.
	self addChild: trackElement.
	self matchParent
]

{ #category : #initialization }
ToScrollableBarElement >> installFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeNode := self newNode.
	fakeNode id: #fakeNode.
	fakeNode holder dataItem: fakeDataItem.
	self nodeBuilder value: fakeNode value: fakeNode holder.
	self isHorizontal
		ifTrue: [
			fakeNode width: 0.
			fakeNode constraintsDo: [ :c |
				c vertical matchParent.
				c flow vertical alignCenter.
				c linear vertical alignCenter ] ]
		ifFalse: [
			fakeNode height: 0.
			fakeNode constraintsDo: [ :c |
				c horizontal matchParent.
				c flow horizontal alignCenter.
				c linear horizontal alignCenter ] ].

	fakeNode margin: BlInsets empty.

	" add the fake node (to keep a constant minimum height )"
	trackElement addChild: fakeNode
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

	trackElement childrenDo: [ :node | aBlock value: node]
]
