Class {
	#name : #ToSelectionGroup,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection element' }
ToSelectionGroup >> createSelectionElementIn: aListElement [

	| selectionElement |
	selectionElement := option newSelectionElementFor: aListElement.
	selectionElement nodes: self nodes.
	^ selectionElement
]

{ #category : #accessing }
ToSelectionGroup >> nodes [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectionGroup >> option: aSelectionOption [

	option := aSelectionOption
]
