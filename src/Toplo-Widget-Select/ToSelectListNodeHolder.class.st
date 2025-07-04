Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #testing }
ToSelectListNodeHolder >> selectElement [

	^ self listElement selectElement
]
