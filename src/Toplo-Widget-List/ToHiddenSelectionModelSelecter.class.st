Class {
	#name : #ToHiddenSelectionModelSelecter,
	#superclass : #ToAdditionalSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToHiddenSelectionModelSelecter >> eventClass [

	^ ToListHiddenSelectionChangedEvent
]

{ #category : #accessing }
ToHiddenSelectionModelSelecter >> uniqueId [

	^ #hidden
]
