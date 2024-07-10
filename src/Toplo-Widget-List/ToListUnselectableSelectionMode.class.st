Class {
	#name : #ToListUnselectableSelectionMode,
	#superclass : #ToListAdditionalSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListUnselectableSelectionMode >> defaultListEventHandlerClass [

	^ ToListUnselectableSelectionElementEventHandler 
]
