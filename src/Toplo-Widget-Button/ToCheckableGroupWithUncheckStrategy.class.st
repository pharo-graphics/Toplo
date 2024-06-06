Class {
	#name : #ToCheckableGroupWithUncheckStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> checkChangePreNotification: aPreCheckableChangedEvent in: aGroup [

	aPreCheckableChangedEvent checked ifTrue: [ 
		aGroup uncheckAllExcept: aPreCheckableChangedEvent currentTarget ]
]
