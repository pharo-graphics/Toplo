Class {
	#name : #ToCheckableGroupWithUncheckStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> checked: aCheckable in: aGroup [

	aCheckable privateCheck.
	(aGroup buttons select: [ :b | b ~= aCheckable and: [b isChecked]]) ifNotEmpty: [
		:uncheckedBtns |
		uncheckedBtns do: [ :b | b privateUncheck ].
		^ self ].
	aGroup notifyChanged
]

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> unchecked: aCheckable in: aGroup [

	aCheckable privateUncheck.
	aGroup notifyChanged

]
