Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #testing }
ToSelectListNodeHolder >> isDisabled [

	^ super isDisabled or: [ self isUnselectable  ]
]

{ #category : #testing }
ToSelectListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex: self position
]
