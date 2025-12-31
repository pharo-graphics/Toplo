Class {
	#name : #ToListNodeForTest,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #'t - labeled icon' }
ToListNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]
