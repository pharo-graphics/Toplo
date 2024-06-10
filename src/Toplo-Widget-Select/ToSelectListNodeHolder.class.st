Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #testing }
ToSelectListNodeHolder >> isDisabled [

	^ super isDisabled or: [ self isUnselectable  ]
]
