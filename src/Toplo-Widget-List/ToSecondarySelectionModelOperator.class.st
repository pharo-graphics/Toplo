Class {
	#name : #ToSecondarySelectionModelOperator,
	#superclass : #ToStandardSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Operator'
}

{ #category : #'command operations' }
ToSecondarySelectionModelOperator >> scrollCommand: aCommand [ 
	" "

	" to ensure that wrap-around when scrolling works as expected. 
	If not done, the wrap-around comme back to the last mouse move event position"

	aCommand target spaceDo: [ :sp |
		sp mouseProcessor lastMouseMoveEvent ifNotNil: [ :e |
			e consume ] ].
	
	aCommand target scrollToDataSourcePosition: aCommand index
]
