Class {
	#name : #ToListNodeForTest,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-Tests-List'
}

{ #category : #'t - labeled icon' }
ToListNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]
