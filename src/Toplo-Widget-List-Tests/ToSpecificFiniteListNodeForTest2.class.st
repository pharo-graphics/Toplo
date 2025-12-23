Class {
	#name : #ToSpecificFiniteListNodeForTest2,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToSpecificFiniteListNodeForTest2 >> initialize [ 

	super initialize.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]
