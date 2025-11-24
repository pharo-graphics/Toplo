Class {
	#name : #ToTableNode,
	#superclass : #ToListNode,
	#traits : 'TToTableNode',
	#classTraits : 'TToTableNode classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #skin }
ToTableNode >> addCellContainer: aCellContainer [

	self addChild: aCellContainer
]

{ #category : #skin }
ToTableNode >> newRawSkin [ 

	^ ToTableNodeSkin new
]
