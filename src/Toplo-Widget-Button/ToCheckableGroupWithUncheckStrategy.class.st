Class {
	#name : #ToCheckableGroupWithUncheckStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> checkRequestEvent: aCheckRequest in: aGroup [

	aCheckRequest checked ifTrue: [ 
		aGroup uncheckAllExcept: aCheckRequest currentTarget ]
]
