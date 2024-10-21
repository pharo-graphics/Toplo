Class {
	#name : #ToMultiSelectListNodeHolder,
	#superclass : #ToListNodeHolder,
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
