Class {
	#name : #ToSelectionWithElement,
	#superclass : #ToSelectionRepresentation,
	#instVars : [
		'cachedSelectionElement',
		'preComputedBounds'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection element' }
ToSelectionWithElement >> createSelectionElementIn: aListElement option: aSelectionRepresentationOption [

	cachedSelectionElement := aSelectionRepresentationOption newSelectionElementIn: aListElement.
	cachedSelectionElement nodes: self nodes.
	preComputedBounds := cachedSelectionElement boundsFromNodesIn: aListElement
]

{ #category : #removing }
ToSelectionWithElement >> onRemovedFromListElement: aListElement [

	cachedSelectionElement ifNil: [  ^ self ].
	cachedSelectionElement removeFromParent.
	cachedSelectionElement := nil.
	preComputedBounds := nil
]

{ #category : #accessing }
ToSelectionWithElement >> preComputedBounds [

	^ preComputedBounds  
]

{ #category : #'private - selection element' }
ToSelectionWithElement >> refreshSelectionElementIn: aListElement option: aSelectionRepresentationOption [

	self
		createSelectionElementIn: aListElement
		option: aSelectionRepresentationOption
]

{ #category : #accessing }
ToSelectionWithElement >> selectionElement [

	^ cachedSelectionElement 
]

{ #category : #accessing }
ToSelectionWithElement >> updatedSelectionElementIn: aListElement [

	cachedSelectionElement position: preComputedBounds origin.
	cachedSelectionElement size: preComputedBounds extent.
	^ cachedSelectionElement
]
