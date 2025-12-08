"
I'm node manager for finite lists.

"
Trait {
	#name : #TToFiniteNodeManager,
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #'t - finite node manager - initialization' }
TToFiniteNodeManager >> newNodeContainer [ 

	^ ToFiniteListNodeContainer new
]
