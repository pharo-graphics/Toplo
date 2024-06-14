Class {
	#name : #ToSegmentNodeManager,
	#superclass : #ToCheckableNodeManager,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentNodeManager >> constraintNode: aNode [

	| seg |
	super constraintNode: aNode.
	seg := aNode holder checkableBarElement.
	aNode childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter.
			c horizontal matchParent.
			c vertical matchParent ] ].
	seg isHorizontal ifTrue: [ ^ self ].
	seg canMatchParentHorizontallyInVerticalSegmented ifFalse: [ ^ self ].
	aNode constraintsDo: [ :c | c horizontal matchParent ]
]
