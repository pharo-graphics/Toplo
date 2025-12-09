Class {
	#name : #ToWrappedGenericListElement,
	#superclass : #ToAbstractWrappedListElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #initialization }
ToWrappedGenericListElement >> defaultNodeManagerClass [ 

	^ ToWrappedListGenericNodeManager 
]
