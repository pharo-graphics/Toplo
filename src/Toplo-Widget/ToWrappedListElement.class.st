Class {
	#name : #ToWrappedListElement,
	#superclass : #ToBasicWrappedListElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToWrappedListElement >> defaultNodeManagerClass [ 

	^ ToWrappedListGenericNodeManager 
]
