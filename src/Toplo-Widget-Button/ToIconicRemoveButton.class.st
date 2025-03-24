Class {
	#name : #ToIconicRemoveButton,
	#superclass : #ToIconicButton,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #initialization }
ToIconicRemoveButton >> initialize [ 

	super initialize.
	self newClickAction: [ self fireEvent: ToRemoveButtonClickedEvent new ].
	self id: #'remove-button'
]

{ #category : #'instance creation' }
ToIconicRemoveButton >> newRawSkin [ 

	^ ToIconicRemoveButtonSkin new
]
