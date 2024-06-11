Class {
	#name : #ToCheckableGroupWithUncheckStrategy,
	#superclass : #ToCheckableGroupStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> allowChangeWith: aCheckValue in: aGroup forCheckable: aCheckable [

	aCheckValue ifTrue: [ aGroup uncheckAllExcept: aCheckable ].
	^ true
]
