Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #testing }
ToSelectListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex: self position
]
