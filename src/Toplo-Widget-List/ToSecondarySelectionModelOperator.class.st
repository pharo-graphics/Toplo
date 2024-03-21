Class {
	#name : #ToSecondarySelectionModelOperator,
	#superclass : #ToStandardSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToSecondarySelectionModelOperator >> listScrollCommand: aCommand in: aTarget [
	" "

	" to ensure that wrap-around when scrolling works as expected. 
	If not done, the wrap-around comme back to the last mouse move event position"

	aTarget spaceDo: [ :sp |
		sp mouseProcessor lastMouseMoveEvent ifNotNil: [ :e |
			e consumed: true ] ].
	
	aTarget scrollToIndex: aCommand index
]

{ #category : #'private command application' }
ToSecondarySelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aCommand selectionChanged ifFalse: [ ^ self ].

	aTarget dispatchEvent:
		(ToListSecondarySelectionChangedEvent new
			 selectionModel: self selectionModel copy;
			 yourself)
]
