Class {
	#name : #ToCheckableGroupWithUncheckStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> checkRequestEvent: aCheckRequest in: aGroup [

	aCheckRequest checked ifTrue: [ 
		aGroup uncheckAllExcept: aCheckRequest currentTarget ].
	aCheckRequest currentTarget privateChecked: aCheckRequest checked.
	aGroup notifyChanged
]
