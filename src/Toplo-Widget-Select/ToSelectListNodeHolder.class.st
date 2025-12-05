Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #testing }
ToSelectListNodeHolder >> selectElement [

	^ self listElement selectElement
]
