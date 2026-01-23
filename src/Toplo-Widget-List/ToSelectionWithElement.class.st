Class {
	#name : #ToSelectionWithElement,
	#superclass : #ToSelectionRepresentation,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToSelectionWithElement >> newSelectionElementIn: aListElement option: aSelectionRepresentationOption [

	^ Array with: (aSelectionRepresentationOption
			   newSelectionElementIn: aListElement
			   forNodeContainers: self nodeContainers)
]
