Class {
	#name : #ToItemListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-Menu-Item-List'
}

{ #category : #'as yet unclassified' }
ToItemListElement >> defaultNodeManagerClass [

	^ ToItemNodeManager
]

{ #category : #initialization }
ToItemListElement >> initialize [

	super initialize.
	self primarySelectionMode makeDisabledUnselectable: true.
	self focusability: BlFocusability none
]

{ #category : #'as yet unclassified' }
ToItemListElement >> newRawSkin [ 

	^ ToItemListElementSkin new
]
