Class {
	#name : #ToSpecificListNodeForTest,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #'as yet unclassified' }
ToSpecificListNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]
