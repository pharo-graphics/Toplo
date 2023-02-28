Class {
	#name : #ToCheckableGroupWithUncheckStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> checked: aCheckable in: aGroup [

	aCheckable privateCheck.
	aGroup uncheckAllExcept: aCheckable ifFoundDo: [ ^ self ].
	aGroup notifyChanged
]

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> unchecked: aCheckable in: aGroup [

	aCheckable privateUncheck.
	aGroup notifyChanged

]
