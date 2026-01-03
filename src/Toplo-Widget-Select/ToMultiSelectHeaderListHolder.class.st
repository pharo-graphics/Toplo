Class {
	#name : #ToMultiSelectHeaderListHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectHeaderListHolder >> indexOfDataItem [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is done by deselecting the corresponding list item in the select popup list "

	^ self selectElement sieve originalData indexOf: self dataItem
]

{ #category : #'accessing - list' }
ToMultiSelectHeaderListHolder >> popupListElement [

	^ self selectElement popupListElement
]

{ #category : #removing }
ToMultiSelectHeaderListHolder >> removeNodeFromList [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is done by deselecting the corresponding list item in the select popup list "

	self selecter deselectIndex: self indexOfDataItem 
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListHolder >> selectElement [

	^  self listElement selectElement
]

{ #category : #accessing }
ToMultiSelectHeaderListHolder >> selecter [

	^ self selectElement selecter
]
