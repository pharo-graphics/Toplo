Class {
	#name : #ToCheckableGroupNoneStrategy,
	#superclass : #ToCheckableGroupStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupNoneStrategy >> allowChangeWith: aCheckValue in: aGroup forCheckable: aCheckable [

	^ true

	
]

{ #category : #testing }
ToCheckableGroupNoneStrategy >> isNoneStrategy [

	^ true
]
