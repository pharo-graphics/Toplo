Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #testing }
ToSelectListNodeHolder >> isDisabled [

	^ super isDisabled or: [ self isUnselectable  ]
]

{ #category : #testing }
ToSelectListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex: self position
]

{ #category : #accessing }
ToSelectListNodeHolder >> select: anObject [

	select := anObject
]
