Class {
	#name : #ToSelectionGroup,
	#superclass : #Object,
	#instVars : [
		'selectionElement',
		'selectionOption'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToSelectionGroup >> nodes [

	^ self subclassResponsibility 
]

{ #category : #private }
ToSelectionGroup >> removeSelectionElement [

	selectionElement ifNil: [ ^ self ].
	selectionElement removeFromParent.
	selectionElement := nil
]

{ #category : #accessing }
ToSelectionGroup >> selectionElementFrom: aListElement [

	^ selectionElement
		  ifNil: [
			  selectionElement := selectionOption newSelectionElement.
			  selectionElement listElement: aListElement.
			  selectionElement nodes: self nodes ]
		  ifNotNil: [
			  selectionElement
				  yourself ]
]

{ #category : #accessing }
ToSelectionGroup >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]
