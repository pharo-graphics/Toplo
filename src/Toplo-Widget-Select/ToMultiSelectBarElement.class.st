Class {
	#name : #ToMultiSelectBarElement,
	#superclass : #ToBarElement,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectBarElement >> defaultEventHandler [ 

	^ ToMultiSelectBarEventHandler new
]
