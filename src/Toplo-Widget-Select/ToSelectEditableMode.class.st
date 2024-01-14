Class {
	#name : #ToSelectEditableMode,
	#superclass : #ToSelectMode,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #adding }
ToSelectEditableMode >> addDataNode: aNode [

	select nodeContainer addChild: aNode before: select textField
]

{ #category : #'accessing selection' }
ToSelectEditableMode >> deselectIndex: anIndex [

	select selectionModel deselectIndex: anIndex.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]

{ #category : #private }
ToSelectEditableMode >> filterString [

	^ select textField text asString
]

{ #category : #private }
ToSelectEditableMode >> filterTextFieldUpdated: anEvent [

	select listElement dispatchEvent:
		(ToListFilterRequest new pattern: self filterString)
]

{ #category : #initialization }
ToSelectEditableMode >> initializeMultiSelectNodeContainer: anElement [

	| textField |
	super initializeMultiSelectNodeContainer: anElement.
	textField := select newTextField.
	textField requestFocus.
	anElement addChild: textField
]

{ #category : #testing }
ToSelectEditableMode >> isEditableMode [

	^ true
]

{ #category : #'accessing selection' }
ToSelectEditableMode >> selectIndex: anIndex [

	select selectionModel selectIndex: anIndex.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]

{ #category : #'accessing selection' }
ToSelectEditableMode >> selectIndexes: aCollection [

	select selectionModel selectIndexes: aCollection.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]
