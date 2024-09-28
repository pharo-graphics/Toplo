Class {
	#name : #ToMultiSelectNodeHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectNodeHolder >> dataAccessor [

	^ self sieve originalData
]

{ #category : #removing }
ToMultiSelectNodeHolder >> removeNodeFromBar [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is by deselecting the corresponding list item in the select list "

	self selecter deselectIndex: self dataItem index
]

{ #category : #accessing }
ToMultiSelectNodeHolder >> selectElement [

	^  self listElement selectElement
]

{ #category : #accessing }
ToMultiSelectNodeHolder >> selecter [

	^  self selectElement selecter
]

{ #category : #accessing }
ToMultiSelectNodeHolder >> selectionModel [

	^ self selectElement selectionModel
]

{ #category : #accessing }
ToMultiSelectNodeHolder >> sieve [

	^  self listElement sieve
]
