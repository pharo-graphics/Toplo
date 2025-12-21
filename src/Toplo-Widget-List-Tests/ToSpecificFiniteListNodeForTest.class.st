Class {
	#name : #ToSpecificFiniteListNodeForTest,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #'t - labeled icon' }
ToSpecificFiniteListNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]
