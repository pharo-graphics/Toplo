Class {
	#name : #ToListNodeManager,
	#superclass : #ToAbstractListNodeManager,
	#category : #'Toplo-Widget-List-Core-ListElement'
}

{ #category : #initialization }
ToListNodeManager >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]
