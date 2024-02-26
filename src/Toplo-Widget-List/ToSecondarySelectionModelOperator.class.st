Class {
	#name : #ToSecondarySelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToSecondarySelectionModelOperator >> applyCommand: aCommand for: aTarget withApplicationBlock: aBlock [

	| silent selectionModelChanged |
	previousModel ifNil: [ previousModel := self selectionModel copy ].

	super applyCommand: aCommand for: aTarget withApplicationBlock: aBlock.

	selectionModelChanged := previousModel ~= self selectionModel.
	silent := aCommand silent or: [ selectionModelChanged not ].

	selectionModelChanged ifTrue: [
		aTarget dispatchEvent: (ToSecondarySelectionCommandAppliedEvent new
				 operator: self;
				 command: aCommand) ].

	silent ifTrue: [ ^ self ].
	previousModel := self selectionModel copy.
	aTarget notifyPrimarySelectionChanged: (ToListSecondarySelectionChangedEvent new
			 selectionModel: previousModel;
			 yourself)
]
