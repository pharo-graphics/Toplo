Class {
	#name : #ToSpecificFiniteListNodeForTest,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #'t - labeled icon' }
ToSpecificFiniteListNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]
