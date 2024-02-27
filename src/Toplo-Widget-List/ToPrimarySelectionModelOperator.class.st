Class {
	#name : #ToPrimarySelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#instVars : [
		'previousModel'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToPrimarySelectionModelOperator >> applyCommand: aCommand for: aTarget withApplicationBlock: aBlock [

	| silent selectionModelChanged |
	previousModel ifNil: [ previousModel := self selectionModel copy ].

	super applyCommand: aCommand for: aTarget withApplicationBlock: aBlock.

	selectionModelChanged := previousModel ~= self selectionModel.
	silent := aCommand silent or: [ selectionModelChanged not ].

	selectionModelChanged ifTrue: [
		aTarget dispatchEvent: (ToPrimarySelectionCommandAppliedEvent new
				 operator: self;
				 command: aCommand) ].

	silent ifTrue: [ ^ self ].
	previousModel := self selectionModel copy.
	aTarget notifyPrimarySelectionChanged: (ToListPrimarySelectionChangedEvent new
			 selectionModel: previousModel;
			 yourself)
]