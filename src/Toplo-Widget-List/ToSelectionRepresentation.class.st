Class {
	#name : #ToSelectionRepresentation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToSelectionRepresentation >> nodes [
	^ self subclassResponsibility
]

{ #category : #removing }
ToSelectionRepresentation >> onRemovedFromListElement: aListElement [
]
