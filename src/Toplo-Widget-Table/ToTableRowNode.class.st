Class {
	#name : #ToTableRowNode,
	#superclass : #ToListNode,
	#traits : 'TToTableNode',
	#classTraits : 'TToTableNode classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #skin }
ToTableRowNode >> addCellContainer: aCellContainer [

	self addChild: aCellContainer
]

{ #category : #skin }
ToTableRowNode >> newRawSkin [ 

	^ ToTableRowNodeSkin new
]
