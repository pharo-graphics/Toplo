"
I define the multiple selection strategy. 
I allow tables using me to manage multiple selection rows.
"
Class {
	#name : #ToFTMultipleSelectionStrategy,
	#superclass : #ToFTSelectionStrategy,
	#category : #'Toplo-FastTable-Selection'
}

{ #category : #testing }
ToFTMultipleSelectionStrategy >> isMultiple [
	^ true
]

{ #category : #private }
ToFTMultipleSelectionStrategy >> selectAppendingIndex: index [
	| currentSelection newSelection |
	currentSelection := self table selectedIndexes.

	newSelection := (currentSelection includes: index)
		ifTrue: [ currentSelection copyWithout: index ]
		ifFalse: [ currentSelection copyWithFirst: index].

	self table selectIndexes: newSelection
]

{ #category : #accessing }
ToFTMultipleSelectionStrategy >> selectIndex: index event: event [
	event shiftPressed ifTrue: [ ^ self selectIndexesUpTo: index ].
	OSPlatform current isMacOS
		ifTrue: [ event commandKeyPressed ifTrue: [ ^ self selectAppendingIndex: index ] ]
		ifFalse: [ event controlKeyPressed ifTrue: [ ^ self selectAppendingIndex: index ] ].
	self toggleIndex: index
]

{ #category : #private }
ToFTMultipleSelectionStrategy >> selectIndexes: index previous: oldSelection [
	"I ensure the selected index is the first in selection range so I can handle it better.
	 I do not like to assume and probably I will need the concept of 'selection', but for now
	 let's not abuse :)"

	self table selectIndexes: (((oldSelection includes: index) ifTrue: [ oldSelection copyWithout: index ] ifFalse: [ oldSelection ]) copyWithFirst: index)
]

{ #category : #private }
ToFTMultipleSelectionStrategy >> selectIndexesUpTo: endIndex [
	"Selects a range of selectables, from what is already selected to a new index.
	 This is used in case of multiple selections (when holding shift)"

	| oldSelected firstIndex |
	oldSelected := self table selectedIndexes.
	firstIndex :=  oldSelected
		ifNotEmpty: [ oldSelected first ]
		ifEmpty: [ endIndex ].

	self selectIndexes: endIndex previous: (oldSelected union: (self table selectionModeStrategy indexesToSelectInMultipleSelectionFrom: firstIndex to: endIndex))
]
