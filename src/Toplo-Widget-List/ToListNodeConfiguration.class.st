Class {
	#name : #ToListNodeConfiguration,
	#superclass : #ToWidgetConfiguration,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #hook }
ToListNodeConfiguration >> applyOn: aNode [

	super applyOn: aNode.
	aNode constraintsDo: [ :c |
		| l |
		l := aNode holder listElement.
		l isHorizontal
			ifTrue: [ c horizontal fitContent ]
			ifFalse: [ c horizontal matchParent ].
		c vertical fitContent ].
	aNode holder initializeNode
]
