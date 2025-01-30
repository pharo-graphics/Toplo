Class {
	#name : #ToTagNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #removing }
ToTagNodeHolder >> removeNodeFromBar [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is done by deselecting the corresponding list item in the select popu list "

	self dataSource removeAt: self position
]

{ #category : #accessing }
ToTagNodeHolder >> tagModel [

	^ self dataItem
]

{ #category : #accessing }
ToTagNodeHolder >> withCloseButton [

	^  self listElement withCloseButton
]
