Class {
	#name : #ToIconicExpandButton,
	#superclass : #ToIconicButton,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #initialization }
ToIconicExpandButton >> initialize [ 

	super initialize.
	self newClickAction: [ self fireEvent: ToExpandButtonClickedEvent new ].
	self id: #'expand-iconic-button'
]

{ #category : #'instance creation' }
ToIconicExpandButton >> newRawSkin [ 

	^ ToIconicExpandButtonSkin new
]
