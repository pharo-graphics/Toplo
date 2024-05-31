Class {
	#name : #ToMultiSelectListNodeHolder,
	#superclass : #ToSelectListNodeHolder,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #testing }
ToMultiSelectListNodeHolder >> isDisabled [

	^ super isDisabled or: [ self isUnselectable  ]
]

{ #category : #testing }
ToMultiSelectListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex: self position
]
