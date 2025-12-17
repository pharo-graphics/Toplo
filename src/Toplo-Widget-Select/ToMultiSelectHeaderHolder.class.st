Class {
	#name : #ToMultiSelectHeaderHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectHeaderHolder >> indexOfDataItem [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is done by deselecting the corresponding list item in the select popup list "

	^ self selectElement sieve originalData indexOf: self dataItem
]

{ #category : #'accessing - list' }
ToMultiSelectHeaderHolder >> popupListElement [

	^ self selectElement popupListElement
]

{ #category : #removing }
ToMultiSelectHeaderHolder >> removeNodeFromList [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is done by deselecting the corresponding list item in the select popup list "

	self selecter deselectIndex: self indexOfDataItem 
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderHolder >> selectElement [

	^  self listElement selectElement
]

{ #category : #accessing }
ToMultiSelectHeaderHolder >> selecter [

	^ self selectElement selecter
]
