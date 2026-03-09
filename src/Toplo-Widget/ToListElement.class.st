Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager  
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]
