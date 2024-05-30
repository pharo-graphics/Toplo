Class {
	#name : #ToSecondarySelectionModelOperator,
	#superclass : #ToStandardSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToSecondarySelectionModelOperator >> notifySelectionChangedAfter: aCommand [ 

	aCommand selectionChanged ifFalse: [ ^ self ].

	aCommand target dispatchEvent:
		(ToListSecondarySelectionChangedEvent new
			 selectionModel: aCommand selectionModel;
			 yourself)
]

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
