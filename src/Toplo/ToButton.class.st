Class {
	#name : #ToButton,
	#superclass : #ToBasicButton,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #initialization }
ToButton >> defaultViewModel [

	^ ToButtonModel new
]

{ #category : #accessing }
ToButton >> iconImage: anElement [

	self viewModel iconImage: anElement
]
