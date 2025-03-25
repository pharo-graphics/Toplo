Class {
	#name : #ToIconicAddButton,
	#superclass : #ToIconicButton,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #initialization }
ToIconicAddButton >> initialize [ 

	super initialize.
	self newClickAction: [ self fireEvent: ToAddButtonClickedEvent new ].
	self id: #'add-iconic-button'
]

{ #category : #'instance creation' }
ToIconicAddButton >> newRawSkin [ 

	^ ToIconicAddButtonSkin new
]
