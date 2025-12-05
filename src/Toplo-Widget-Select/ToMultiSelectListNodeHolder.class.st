Class {
	#name : #ToMultiSelectListNodeHolder,
	#superclass : #ToSelectListNodeHolder,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #testing }
ToMultiSelectListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex: self position
]
