Class {
	#name : #ToSegmentNodeManager,
	#superclass : #ToCheckableNodeManager,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentNodeManager >> constraintNode: aNode [

	| checkableBar |
	checkableBar := aNode holder checkableBarElement.
	aNode constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	checkableBar nodeScrolling ifTrue: [ ^ self ].
	aNode autoDistribute: checkableBar nodeAutoDistribution
]
