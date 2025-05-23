Class {
	#name : #ToSelectionRepresentation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToSelectionRepresentation >> = other [

	^ self class = other class
]

{ #category : #comparing }
ToSelectionRepresentation >> hash [

	^ self class hash
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
ToSelectionRepresentation >> nodes [
	^ self subclassResponsibility
]

{ #category : #removing }
ToSelectionRepresentation >> onRemovedFromListElement: aListElement [

	self subclassResponsibility 
]

{ #category : #'private - selection element' }
ToSelectionRepresentation >> refreshSelectionElementIn: aListElement option: aListSelectionRepresentationOption [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectionRepresentation >> selectionBounds [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToSelectionRepresentation >> selectionElements [

	^ self subclassResponsibility 
]
