"
I'm a generic list 
"
Class {
	#name : #ToGenericFiniteListElement,
	#superclass : #ToGenericListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericFiniteListElement >> defaultInnerElementClass [ 

	^ ToInnerFiniteListElement
]

{ #category : #initialization }
ToGenericFiniteListElement >> initialize [ 

	super initialize.
	useInfiniteLayout := false.

]
