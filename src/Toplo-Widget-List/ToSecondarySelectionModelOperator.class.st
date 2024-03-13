Class {
	#name : #ToSecondarySelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
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
	super listScrollCommand: aCommand in: aTarget
]

{ #category : #'private command application' }
ToSecondarySelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aTarget onSecondarySelectionCommandApplied: aCommand
]
