Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToGenericListElement + TToListElementWithDecoration',
	#classTraits : 'TToGenericListElement classTrait + TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-Core-ListElement'
}

{ #category : #initialization }
ToListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager  
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]
