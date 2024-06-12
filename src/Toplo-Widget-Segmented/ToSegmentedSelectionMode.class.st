Class {
	#name : #ToSegmentedSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'event handling' }
ToSegmentedSelectionMode >> onClickEvent: anEvent onNode: aNode [
	" dispatch to the node that makes use of the checking strategy to decide what to do"

	self isDisabled ifTrue: [ ^ self ].
	aNode checked: aNode isChecked not
]
