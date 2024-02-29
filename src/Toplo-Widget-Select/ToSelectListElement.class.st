Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectListElement >> defaultSecondarySelectionEventHandler [ 

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]
