Class {
	#name : #ToMultiSelectHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'accessing - list' }
ToMultiSelectHolder >> popupListElement [

	^ self selectElement popupListElement
]

{ #category : #removing }
ToMultiSelectHolder >> removeNodeFromBar [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is done by deselecting the corresponding list item in the select popup list "

	| index |
	index := self selectElement sieve originalData indexOf:
		         self dataItem.
	self selecter deselectIndex: index
]

{ #category : #'t - select inner container' }
ToMultiSelectHolder >> selectElement [

	^  self listElement selectElement
]

{ #category : #accessing }
ToMultiSelectHolder >> selecter [

	^ self selectElement selecter
]
