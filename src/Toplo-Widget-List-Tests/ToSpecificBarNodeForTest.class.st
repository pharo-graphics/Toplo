Class {
	#name : #ToSpecificBarNodeForTest,
	#superclass : #ToListNode,
	#traits : 'TToBarNode',
	#classTraits : 'TToBarNode classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #'as yet unclassified' }
ToSpecificBarNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]
