Class {
	#name : #ToListNode,
	#superclass : #ToAbstractListNode,
	#classTraits : 'TToListNode classTrait + TToRequestTarget classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #skin }
ToListNode >> newRawSkin [ 

	^ ToListNodeSkin new
]
