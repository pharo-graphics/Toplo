Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectListElement >> defaultSecondarySelectionEventHandler [ 

	^ ToSelectSecondarySelectionElementEventHandler new
]
