Class {
	#name : #ToBasicFiniteListElement,
	#superclass : #ToBasicListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToBasicFiniteListElement >> defaultInnerElementClass [

	^ ToInnerFiniteListElement
]

{ #category : #initialization }
ToBasicFiniteListElement >> initialize [

	super initialize.
	useInfiniteLayout := false.
]
