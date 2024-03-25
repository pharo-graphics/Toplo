Class {
	#name : #ToListPrimarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'api - hooks' }
ToListPrimarySelectionModel >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	disabledSelectionModel := aListElement newSelectionModel.
	disabledSelectionModel onInstalledIn: aListElement.
	hiddenSelectionModel := aListElement newSelectionModel.
	hiddenSelectionModel onInstalledIn: aListElement.
	unselectableSelectionModel := aListElement newSelectionModel.
	hiddenSelectionModel onInstalledIn: aListElement
]

{ #category : #'api - hooks' }
ToListPrimarySelectionModel >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	disabledSelectionModel := nil.
	hiddenSelectionModel := nil.
	unselectableSelectionModel := nil	
]
