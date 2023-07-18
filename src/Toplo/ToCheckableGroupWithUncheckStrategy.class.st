Class {
	#name : #ToCheckableGroupWithUncheckStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> checked: aCheckable in: aGroup [

	aCheckable privateChecked: true.
	aGroup uncheckAllExcept: aCheckable ifFoundDo: [ ^ self ].
	aGroup notifyChanged
]

{ #category : #testing }
ToCheckableGroupWithUncheckStrategy >> unchecked: aCheckable in: aGroup [

	aCheckable privateChecked: false.
	aGroup notifyChanged

]
