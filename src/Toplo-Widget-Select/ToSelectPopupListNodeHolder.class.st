Class {
	#name : #ToSelectPopupListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #testing }
ToSelectPopupListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex: self position
]

{ #category : #testing }
ToSelectPopupListNodeHolder >> selectElement [

	^ self listElement selectElement
]
