Class {
	#name : #ToFiniteListNodeManager,
	#superclass : #ToListNodeManager,
	#traits : 'TToFiniteNodeManager',
	#classTraits : 'TToFiniteNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #'instance creation' }
ToFiniteListNodeManager >> newNodeContainer [ 

	^ ToFiniteListNodeContainer new
]
