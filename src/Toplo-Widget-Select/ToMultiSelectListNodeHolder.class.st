Class {
	#name : #ToMultiSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #testing }
ToMultiSelectListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex: self position
]

{ #category : #testing }
ToMultiSelectListNodeHolder >> selectElement [

	^ self listElement selectElement
]
