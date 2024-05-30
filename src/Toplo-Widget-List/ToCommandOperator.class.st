Class {
	#name : #ToCommandOperator,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #accessing }
ToCommandOperator >> addCommand: aCommand [ 

	aCommand target dispatchEvent: (ToElementCommandAddedEvent new
			 command: aCommand
			 yourself)
]

{ #category : #'command application' }
ToCommandOperator >> applyCommand: aCommand [ 
	
	aCommand applyOn: aCommand operator
]
