Class {
	#name : #ToTableRowNode,
	#superclass : #ToBasicListNode,
	#traits : 'TToTableRowNode',
	#classTraits : 'TToTableRowNode classTrait',
	#category : #'Toplo-Widget-Table'
}

{ #category : #skin }
ToTableRowNode >> addCellContainer: aCellContainer [

	self addChild: aCellContainer
]

{ #category : #skin }
ToTableRowNode >> newRawSkin [ 

	^ ToTableRowNodeSkin new
]
