Class {
	#name : #ToStandardSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> listScrollCommand: aCommand in: aTarget [

	aTarget scrollToIndex: aCommand index
]
