Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #testing }
ToSelectListNodeHolder >> isDisabled [

	^ super isDisabled or: [ self isUnselectable  ]
]
