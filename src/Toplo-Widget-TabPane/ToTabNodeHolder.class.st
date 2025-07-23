Class {
	#name : #ToTabNodeHolder,
	#superclass : #ToItemNodeHolder,
	#category : #'Toplo-Widget-TabPane-TabBar'
}

{ #category : #removing }
ToTabNodeHolder >> checkNextAfterRemovalAtPosition: aPosition [
	" remove from bar and make sure that the next tab (or the last one) is checked after"

	| nextChecked dataAccessor |
	dataAccessor := self listElement dataAccessor.
	dataAccessor ifEmpty: [ ^ self ].
	nextChecked := dataAccessor size < aPosition
		               ifTrue: [ dataAccessor last ]
		               ifFalse: [ dataAccessor at: aPosition ].
	nextChecked checked: true
]
