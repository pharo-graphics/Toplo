Class {
	#name : #ToListDisabledSelectionMode,
	#superclass : #ToListAdditionalSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListDisabledSelectionMode >> defaultListEventHandlerClass [

	^ ToListDisabledSelectionElementEventHandler 
]
