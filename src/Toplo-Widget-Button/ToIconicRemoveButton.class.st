Class {
	#name : #ToIconicRemoveButton,
	#superclass : #ToStandardIconicButton,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #initialization }
ToIconicRemoveButton >> initialize [ 

	super initialize.
	self id: #'remove-button'
]

{ #category : #skin }
ToIconicRemoveButton >> newRawSkin [ 

	^ ToIconicRemoveButtonSkin new
]
