Class {
	#name : #ToTabNodeHolder,
	#superclass : #ToItemNodeHolder,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #removing }
ToTabNodeHolder >> removeNodeFromBar [
	" remove from bar and make sure that the next tab (or the last one) is checked after"

	| index nextChecked dataAccessor |
	self node isRemovable ifFalse: [ ^ self ].
	dataAccessor := self listElement dataAccessor.
	index := self node item isChecked
		         ifTrue: [ self position ]
		         ifFalse: [ 0 ].

	super removeNodeFromBar.

	index > 0 ifFalse: [ ^ self ].
	dataAccessor ifEmpty: [ ^ self ].
	nextChecked := dataAccessor size < index
		               ifTrue: [ dataAccessor last ]
		               ifFalse: [ dataAccessor at: index ].
	nextChecked checked: true
]
