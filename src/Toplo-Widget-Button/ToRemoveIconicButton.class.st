Class {
	#name : #ToRemoveIconicButton,
	#superclass : #ToIconicButton,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #initialization }
ToRemoveIconicButton >> initialize [ 

	super initialize.
	self newClickAction: [ self fireEvent: ToRemoveShotEvent new ].
	self id: #'remove-iconic-button'
]

{ #category : #'instance creation' }
ToRemoveIconicButton >> newRawSkin [ 

	^ ToRemoveIconicButtonSkin new
]
