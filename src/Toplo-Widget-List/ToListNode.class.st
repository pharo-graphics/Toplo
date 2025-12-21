Class {
	#name : #ToListNode,
	#superclass : #ToBasicListNode,
	#classTraits : 'TToListNode classTrait + TToRequestTarget classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #skin }
ToListNode >> newRawSkin [ 

	^ ToListNodeSkin new
]
