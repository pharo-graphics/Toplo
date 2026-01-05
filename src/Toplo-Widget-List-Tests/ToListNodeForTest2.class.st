Class {
	#name : #ToListNodeForTest2,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToListNodeForTest2 >> initialize [ 

	super initialize.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]
