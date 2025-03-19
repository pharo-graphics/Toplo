Class {
	#name : #ToExpandIconicButton,
	#superclass : #ToIconicButton,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #initialization }
ToExpandIconicButton >> initialize [ 

	super initialize.
	self newClickAction: [ self fireEvent: ToExpandShotEvent new ].
	self id: #'expand-iconic-button'
]

{ #category : #'instance creation' }
ToExpandIconicButton >> newRawSkin [ 

	^ ToExpandIconicButtonSkin new
]
