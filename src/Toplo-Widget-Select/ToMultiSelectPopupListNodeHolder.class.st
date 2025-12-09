Class {
	#name : #ToMultiSelectPopupListNodeHolder,
	#superclass : #ToSelectPopupListNodeHolder,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #testing }
ToMultiSelectPopupListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex: self position
]
