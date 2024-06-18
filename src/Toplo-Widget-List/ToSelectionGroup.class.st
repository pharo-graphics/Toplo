Class {
	#name : #ToSelectionGroup,
	#superclass : #Object,
	#instVars : [
		'selectionElement',
		'option'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToSelectionGroup >> createSelectionElementFrom: aListElement [

	selectionElement := option newSelectionElement.
	selectionElement listElement: aListElement.
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

{ #category : #private }
ToSelectionGroup >> removeSelectionElement [

	selectionElement ifNil: [ ^ self ].
	selectionElement removeFromParent.
	selectionElement := nil
]

{ #category : #accessing }
ToSelectionGroup >> selectionElement [

	^ selectionElement
]
