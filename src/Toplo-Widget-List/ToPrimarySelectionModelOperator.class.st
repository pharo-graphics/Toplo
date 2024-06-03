Class {
	#name : #ToPrimarySelectionModelOperator,
	#superclass : #ToStandardSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Operator'
}

{ #category : #'command operations' }
ToPrimarySelectionModelOperator >> scrollCommand: aCommand [ 

	aCommand target scrollToDataSourcePosition: aCommand index
]
