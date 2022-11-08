Class {
	#name : #ToButton,
	#superclass : #ToBasicButton,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #initialization }
ToButton >> defaultViewModel [

	^ ToButtonViewModel new
]

{ #category : #accessing }
ToButton >> iconImage: anElement [

	self viewModel iconImage: anElement
]
