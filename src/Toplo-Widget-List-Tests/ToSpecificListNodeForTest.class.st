Class {
	#name : #ToSpecificListNodeForTest,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #initialization }
ToSpecificListNodeForTest >> initialize [ 

	super initialize.
	self fitContent
]

{ #category : #'t - labeled icon' }
ToSpecificListNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]
