Class {
	#name : #ToListElement,
	#superclass : #ToGenericListElement,
	#traits : 'TToListElementWithDecoration',
	#classTraits : 'TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-Core-ListElement'
}

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]
