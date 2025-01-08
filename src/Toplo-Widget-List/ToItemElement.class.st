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
