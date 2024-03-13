Class {
	#name : #ToDisabledSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToDisabledSelectionModelOperator >> listScrollCommand: aCommand in: aTarget [
	" nothing to do "

	
]

{ #category : #'private command application' }
ToDisabledSelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aTarget onDisabledSelectionCommandApplied: aCommand
]
