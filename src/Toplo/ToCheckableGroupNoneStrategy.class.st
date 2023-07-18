Class {
	#name : #ToCheckableGroupNoneStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupNoneStrategy >> checked: aCheckable in: aGroup [

	aCheckable privateChecked: true.
	aGroup notifyChanged
]

{ #category : #testing }
ToCheckableGroupNoneStrategy >> unchecked: aCheckable in: aGroup [

	aCheckable privateChecked: false.
	aGroup notifyChanged

]
