Class {
	#name : #ToUnselectableSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToUnselectableSelectionModelOperator >> applyCommand: aCommand for: aTarget withApplicationBlock: aBlock [

	| emittedSelectionModel |
	super
		applyCommand: aCommand
		for: aTarget
		withApplicationBlock: aBlock.
	emittedSelectionModel := self selectionModel" copy".
	aTarget notifyUnselectableSelectionChanged: (ToListUnselectableSelectionChangedEvent new
			 selectionModel: emittedSelectionModel;
			 yourself).
]

{ #category : #'command operations' }
ToUnselectableSelectionModelOperator >> listScrollCommand: aCommand for: aTarget [
	" nothing to do "

	
]
