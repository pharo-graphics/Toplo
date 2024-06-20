Class {
	#name : #ToSelectionGroup,
	#superclass : #Object,
	#instVars : [
		'option',
		'cachedSelectionElement'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection element' }
ToSelectionGroup >> createSelectionElementFor: aListElement [

	cachedSelectionElement ifNotNil: [ 'My SelectionElement should have been removed before being created' traceCr ].
	cachedSelectionElement := option newSelectionElementFor: aListElement.
	cachedSelectionElement nodes: self nodes.
	^ cachedSelectionElement
]

{ #category : #accessing }
ToSelectionGroup >> nodes [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectionGroup >> option: aSelectionOption [

	option := aSelectionOption
]

{ #category : #'private - selection element' }
ToSelectionGroup >> removeSelectionElement [

	cachedSelectionElement ifNil: [ ^ self ].
	cachedSelectionElement removeFromParent.
	cachedSelectionElement := nil
]
