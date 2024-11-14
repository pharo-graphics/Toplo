Class {
	#name : #ToAbstractBarNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractBarNodeManager >> constraintFakeNode: aNode [

	| bar |
	bar := aNode holder listElement.
	bar isHorizontal
		ifTrue: [
			aNode constraintsDo: [ :c |
				c horizontal exact: 0.
				c vertical fitContent.
				c flow vertical alignCenter.
				c linear vertical alignCenter ] ]
		ifFalse: [
			aNode constraintsDo: [ :c |
				c vertical exact: 0.
				c horizontal fitContent.
				c flow horizontal alignCenter.
				c linear horizontal alignCenter ] ].
]
