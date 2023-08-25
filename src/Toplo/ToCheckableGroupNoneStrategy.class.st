Class {
	#name : #ToCheckableGroupNoneStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupNoneStrategy >> checkRequestEvent: aCheckRequest in: aGroup [

	aGroup notifyChanged
]
