Class {
	#name : #ToMultiSelectHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectHolder >> dataAccessor [

	^ self sieve originalData
]

{ #category : #removing }
ToMultiSelectHolder >> removeNodeFromBar [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is by deselecting the corresponding list item in the select list "

	self selecter deselectIndex: self dataItem index
]

{ #category : #accessing }
ToMultiSelectHolder >> selectElement [

	^  self listElement selectElement
]

{ #category : #accessing }
ToMultiSelectHolder >> selecter [

	^  self selectElement selecter
]

{ #category : #accessing }
ToMultiSelectHolder >> selectionModel [

	^ self selectElement selectionModel
]

{ #category : #accessing }
ToMultiSelectHolder >> sieve [

	^  self listElement sieve
]
