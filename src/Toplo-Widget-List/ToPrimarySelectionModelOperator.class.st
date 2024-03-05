Class {
	#name : #ToPrimarySelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToPrimarySelectionModelOperator >> applyCommand: aCommand for: aTarget withApplicationBlock: aBlock [

	| selectionModelChanged previousModel |
	previousModel := self selectionModel copy.

	super applyCommand: aCommand for: aTarget withApplicationBlock: aBlock.

	selectionModelChanged := previousModel ~= self selectionModel.

	selectionModelChanged ifTrue: [
		aTarget dispatchEvent: (ToPrimarySelectionCommandAppliedEvent new
				 operator: self;
				 command: aCommand) ].

	selectionModelChanged ifFalse: [ ^ self ].
	aTarget notifyPrimarySelectionChanged: (ToListPrimarySelectionChangedEvent new
			 selectionModel: self selectionModel" copy";
			 yourself)
]
