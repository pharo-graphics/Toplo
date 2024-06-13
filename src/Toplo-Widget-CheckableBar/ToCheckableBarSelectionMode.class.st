Class {
	#name : #ToCheckableBarSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #'event handling' }
ToCheckableBarSelectionMode >> onClickEvent: anEvent onNode: aNode [
	" dispatch to the node that makes use of the checking strategy to decide what to do"

	self isDisabled ifTrue: [ ^ self ].
	aNode checked: aNode isChecked not
]
