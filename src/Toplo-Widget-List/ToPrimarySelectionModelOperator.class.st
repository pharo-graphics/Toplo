Class {
	#name : #ToPrimarySelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToPrimarySelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aTarget onPrimarySelectionCommandApplied: aCommand
]
