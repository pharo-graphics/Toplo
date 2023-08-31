Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> buttonInserted: aCheckable in: aGroup [

	aCheckable isChecked ifTrue: [
		(aGroup buttons select: [ :b | b ~= aCheckable and: [ b checked ] ])
			do: [ :b | b privateChecked: false ] ].
	super buttonInserted: aCheckable in: aGroup
]

{ #category : #testing }
ToCheckableGroupStrictStrategy >> checkRequestEvent: aCheckRequest in: aGroup [

	aCheckRequest checked ifFalse: [ 
		aCheckRequest processed: true.
		^ self ].
	aGroup uncheckAllExcept: aCheckRequest currentTarget.
	aCheckRequest currentTarget privateChecked: aCheckRequest checked.
	aGroup notifyChanged
]
