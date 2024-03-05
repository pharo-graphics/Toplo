Class {
	#name : #ToSecondarySelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToSecondarySelectionModelOperator >> applyCommand: aCommand in: aTarget withApplicationBlock: aBlock [

	super applyCommand: aCommand in: aTarget withApplicationBlock: aBlock.
	aTarget notifySecondarySelectionChanged: (ToListSecondarySelectionChangedEvent new
			 selectionModel: self selectionModel copy;
			 yourself)
]

{ #category : #'command operations' }
ToSecondarySelectionModelOperator >> listScrollCommand: aCommand in: aTarget [
	" "

	" to ensure that wrap-around when scrolling works as expected. 
	If not done, the wrap-around comme back to the last mouse move event position"

	aTarget spaceDo: [ :sp |
		sp mouseProcessor lastMouseMoveEvent ifNotNil: [ :e |
			e consumed: true ] ].
	super listScrollCommand: aCommand in: aTarget
]
