Class {
	#name : #ToMultiSelectHolder,
	#superclass : #ToTagNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'accessing - list' }
ToMultiSelectHolder >> popupListElement [

	^ self selectElement popupListElement
]

{ #category : #'as yet unclassified' }
ToMultiSelectHolder >> popupListSelecter [

	^ self selectElement popupListSelecter
]

{ #category : #'accessing - list' }
ToMultiSelectHolder >> popupListSieve [

	^ self listElement popupListSieve
]

{ #category : #removing }
ToMultiSelectHolder >> removeNodeFromBar [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is done by deselecting the corresponding list item in the select popu list "
	| index |
	index := self popupListSieve originalData indexOf: self dataItem data.
	self popupListSelecter deselectIndex: index
]

{ #category : #'as yet unclassified' }
ToMultiSelectHolder >> selectElement [

	^  self listElement selectElement
]
