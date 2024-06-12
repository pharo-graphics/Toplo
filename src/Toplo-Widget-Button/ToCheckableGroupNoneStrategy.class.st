Class {
	#name : #ToCheckableGroupNoneStrategy,
	#superclass : #ToCheckableGroupStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupNoneStrategy >> allowChangeWith: aCheckValue in: aGroup forCheckable: aCheckable [

	^ true

	
]

{ #category : #testing }
ToCheckableGroupNoneStrategy >> isNoneStrategy [

	^ true
]
