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

{ #category : #accessing }
ToSelectionRepresentation >> nodeContainers [
	^ self subclassResponsibility
]

{ #category : #'private - selection updating' }
ToSelectionRepresentation >> stream: aStream withNewSelectionElementIn: aListElement option: aSelectionOption [

	^ self subclassResponsibility
]
