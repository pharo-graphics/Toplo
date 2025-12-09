Class {
	#name : #ToSpecificFiniteListNodeForTest,
	#superclass : #ToListNode,
	#traits : 'TToFiniteListNode',
	#classTraits : 'TToFiniteListNode classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToSpecificFiniteListNodeForTest >> initialize [ 

	super initialize.
	self initializeAsBarNode.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #'t - labeled icon' }
ToSpecificFiniteListNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]
