Class {
	#name : #ToListSecondarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'api - hooks' }
ToListSecondarySelectionModel >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	disabledSelectionModel := aListElement selectionModel disabledSelectionModel.
	hiddenSelectionModel := aListElement selectionModel hiddenSelectionModel.
	unselectableSelectionModel := aListElement selectionModel unselectableSelectionModel
]

{ #category : #'api - hooks' }
ToListSecondarySelectionModel >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	disabledSelectionModel := nil.
	hiddenSelectionModel := nil.
	unselectableSelectionModel := nil	
]
