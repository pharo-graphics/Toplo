Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #testing }
ToSelectListNodeHolder >> isGroup [

	^ self isUnselectable
]

{ #category : #testing }
ToSelectListNodeHolder >> isHidden [

	^ self isSelected
]
