Class {
	#name : #ToDisabledSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToDisabledSelectionModelOperator >> applyCommand: aCommand in: aTarget withApplicationBlock: aBlock [

	| emittedSelectionModel |
	super
		applyCommand: aCommand
		in: aTarget
		withApplicationBlock: aBlock.
	emittedSelectionModel := self selectionModel.
	aTarget notifyDisabledSelectionChanged: (ToListDisabledSelectionChangedEvent new
			 selectionModel: emittedSelectionModel;
			 yourself).
]

{ #category : #'command operations' }
ToDisabledSelectionModelOperator >> listScrollCommand: aCommand in: aTarget [
	" nothing to do "

	
]
