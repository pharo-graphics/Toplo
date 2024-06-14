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
			c horizontal matchParent.
			c vertical matchParent ] ].
	seg isHorizontal ifFalse: [
		seg canMatchParentHorizontallyInVerticalSegmented ifFalse: [ ^ self ].
		aNode constraintsDo: [ :c | c horizontal matchParent ] ]
]
