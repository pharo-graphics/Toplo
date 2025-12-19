Class {
	#name : #ToSpecificFiniteListNodeForTest2,
	#superclass : #ToListNode,
	#traits : 'TToFiniteListNode',
	#classTraits : 'TToFiniteListNode classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToSpecificFiniteListNodeForTest2 >> initialize [ 

	super initialize.
	self initializeAsFiniteListNode.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]
