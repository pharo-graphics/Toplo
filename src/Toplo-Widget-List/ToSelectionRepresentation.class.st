Class {
	#name : #ToSelectionRepresentation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToSelectionRepresentation >> equivalentTo:  other [

	^ self class = other class
]

{ #category : #testing }
ToSelectionRepresentation >> isComposite [ 

	^ false
]

{ #category : #testing }
ToSelectionRepresentation >> isEmpty [

	^ false
]

{ #category : #'private - selection updating' }
ToSelectionRepresentation >> newSelectionElementIn: aListElement option: aSelectionRepresentationOption [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToSelectionRepresentation >> nodeContainers [
	^ self subclassResponsibility
]
