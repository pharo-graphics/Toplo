Class {
	#name : #ToListSecondarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #updating }
ToListSecondarySelectionModel >> disableIndex: anIndex [

	self disabledSelectionModel selectIndex: anIndex
]

{ #category : #updating }
ToListSecondarySelectionModel >> enableAll [

	self disabledSelectionModel deselectAll
]

{ #category : #updating }
ToListSecondarySelectionModel >> enableIndex: anIndex [

	self disabledSelectionModel deselectIndex: anIndex
]

{ #category : #updating }
ToListSecondarySelectionModel >> hideIndex: anIndex [

	self hiddenSelectionModel selectIndex: anIndex
]

{ #category : #updating }
ToListSecondarySelectionModel >> hideOnlyIndexes: aCollection [

	self hiddenSelectionModel selectOnlyIndexes: aCollection
]

{ #category : #'api - hooks' }
ToListSecondarySelectionModel >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	disabledSelectionModel := aListElement selectionModel disabledSelectionModel.
	hiddenSelectionModel := aListElement selectionModel hiddenSelectionModel.
	unselectableSelectionModel := aListElement selectionModel unselectableSelectionModel
]

{ #category : #updating }
ToListSecondarySelectionModel >> selectableAll [

	self unselectableSelectionModel deselectAll
]

{ #category : #updating }
ToListSecondarySelectionModel >> selectableIndex: anIndex [

	self unselectableSelectionModel deselectIndex: anIndex
]

{ #category : #updating }
ToListSecondarySelectionModel >> unhideAll [

	self hiddenSelectionModel deselectAll
]

{ #category : #updating }
ToListSecondarySelectionModel >> unhideIndex: anIndex [

	self hiddenSelectionModel deselectIndex: anIndex
]

{ #category : #updating }
ToListSecondarySelectionModel >> unhideIndexes: aCollection [

	self hiddenSelectionModel deselectIndexes: aCollection
]

{ #category : #updating }
ToListSecondarySelectionModel >> unselectableIndex: anIndex [

	self unselectableSelectionModel selectIndex: anIndex
]
