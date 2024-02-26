Class {
	#name : #ToSecondarySelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToSecondarySelectionModelOperator >> applyCommand: aCommand for: aTarget withApplicationBlock: aBlock [

	super applyCommand: aCommand for: aTarget withApplicationBlock: aBlock.
	aCommand silent ifTrue: [ ^ self ].
	aTarget notifySecondarySelectionChanged: (ToListSecondarySelectionChangedEvent new
			 selectionModel: self selectionModel copy;
			 yourself)
]

{ #category : #'command operations' }
ToSecondarySelectionModelOperator >> listScrollCommand: aCommand for: aTarget [
	" "

	" to ensure that wrap-around when scrolling works as expected. 
	If not done, the wrap-around comme back to the last mouse move event position"

	aTarget spaceDo: [ :sp |
		sp mouseProcessor lastMouseMoveEvent consumed: true ].
	super listScrollCommand: aCommand for: aTarget
]
