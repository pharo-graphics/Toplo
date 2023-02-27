Class {
	#name : #ToCheckableGroupNoneStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupNoneStrategy >> checked: aCheckable in: aGroup [

	aCheckable privateCheck.
	aGroup notifyChanged
]

{ #category : #testing }
ToCheckableGroupNoneStrategy >> unchecked: aCheckable in: aGroup [

	aCheckable privateUncheck.
	aGroup notifyChanged

]
