Class {
	#name : #ToListPrimarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #updating }
ToListPrimarySelectionModel >> disableIndex: anIndex [

	self disabledSelectionModel selectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> enableAll [

	self disabledSelectionModel deselectAll
]

{ #category : #updating }
ToListPrimarySelectionModel >> enableIndex: anIndex [

	self disabledSelectionModel deselectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> hideIndex: anIndex [

	self hiddenSelectionModel selectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> hideOnlyIndexes: aCollection [

	self hiddenSelectionModel selectOnlyIndexes: aCollection
]

{ #category : #updating }
ToListPrimarySelectionModel >> selectableAll [

	self unselectableSelectionModel deselectAll
]

{ #category : #updating }
ToListPrimarySelectionModel >> selectableIndex: anIndex [

	self unselectableSelectionModel deselectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> unhideAll [

	self hiddenSelectionModel deselectAll
]

{ #category : #updating }
ToListPrimarySelectionModel >> unhideIndex: anIndex [

	self hiddenSelectionModel deselectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> unhideIndexes: aCollection [

	self hiddenSelectionModel deselectIndexes: aCollection
]

{ #category : #updating }
ToListPrimarySelectionModel >> unselectableIndex: anIndex [

	self unselectableSelectionModel selectIndex: anIndex
]
