Class {
	#name : #ToItemElement,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemElement >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #'as yet unclassified' }
ToItemElement >> width: aNumber fromParentNode: aNode [

	self width: aNumber
]
