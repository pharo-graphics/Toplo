Class {
	#name : #ToSelectionRepresentation,
	#superclass : #Object,
	#instVars : [
		'selectionOption'
	],
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

{ #category : #accessing }
ToSelectionRepresentation >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToSelectionRepresentation >> selectionOption: aListSelectionOption [

	selectionOption := aListSelectionOption
]
