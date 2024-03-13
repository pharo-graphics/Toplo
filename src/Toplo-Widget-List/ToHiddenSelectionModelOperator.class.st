Class {
	#name : #ToHiddenSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToHiddenSelectionModelOperator >> listScrollCommand: aCommand in: aTarget [
	" nothing to do "

	
]

{ #category : #'private command application' }
ToHiddenSelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aTarget onHiddenSelectionCommandApplied: aCommand
]
