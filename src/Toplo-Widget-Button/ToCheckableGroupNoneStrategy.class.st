Class {
	#name : #ToCheckableGroupNoneStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupNoneStrategy >> checkRequestEvent: aCheckRequest in: aGroup [

	aGroup notifyChanged
]
