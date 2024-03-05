Class {
	#name : #ToDisabledSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToDisabledSelectionModelOperator >> applyCommand: aCommand for: aTarget withApplicationBlock: aBlock [

	| emittedSelectionModel |
	super
		applyCommand: aCommand
		for: aTarget
		withApplicationBlock: aBlock.
	emittedSelectionModel := self selectionModel.
	aTarget notifyDisabledSelectionChanged: (ToListDisabledSelectionChangedEvent new
			 selectionModel: emittedSelectionModel;
			 yourself).
]

{ #category : #'command operations' }
ToDisabledSelectionModelOperator >> listScrollCommand: aCommand for: aTarget [
	" nothing to do "

	
]
