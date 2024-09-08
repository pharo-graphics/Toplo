Class {
	#name : #ToMultiSelectBarNodeHolder,
	#superclass : #ToBarNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> dataAccessor [

	^ self sieve originalData
]

{ #category : #removing }
ToMultiSelectBarNodeHolder >> removeNodeFromBar [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is by deselecting the corresponding list item in the select list "

	self selecter deselectIndex: self dataItem index
]

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> selectElement [

	^  self barElement selectElement
]

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> selecter [

	^  self selectElement selecter
]

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> selectionModel [

	^ self selectElement selectionModel
]

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> sieve [

	^  self barElement sieve
]
