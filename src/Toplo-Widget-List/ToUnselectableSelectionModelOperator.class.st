Class {
	#name : #ToUnselectableSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToUnselectableSelectionModelOperator >> applyCommand: aCommand in: aTarget withApplicationBlock: aBlock [

	| emittedSelectionModel |
	super
		applyCommand: aCommand
		in: aTarget
		withApplicationBlock: aBlock.
	emittedSelectionModel := self selectionModel" copy".
	aTarget notifyUnselectableSelectionChanged: (ToListUnselectableSelectionChangedEvent new
			 selectionModel: emittedSelectionModel;
			 yourself).
]

{ #category : #'command operations' }
ToUnselectableSelectionModelOperator >> listScrollCommand: aCommand in: aTarget [
	" nothing to do "

	
]
