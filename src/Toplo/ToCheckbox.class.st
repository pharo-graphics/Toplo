Class {
	#name : #ToCheckbox,
	#superclass : #ToBasicButton,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #initialization }
ToCheckbox >> defaultViewModel [ 

	^ ToCheckboxViewModel new
]
