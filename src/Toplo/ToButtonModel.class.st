Class {
	#name : #ToButtonModel,
	#superclass : #ToBasicButtonModel,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToButtonModel >> iconImage: anElement [

	iconViewModel image: anElement
]

{ #category : #'private - accessing - widget' }
ToButtonModel >> privateNewWidget [

	^ ToButton new 
]
