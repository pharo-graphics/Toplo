Class {
	#name : #ToAlbumEditsFeedbackElement,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #initialization }
ToAlbumEditsFeedbackElement >> initialize [

	super initialize.
	self extent: 25 @ 25.
	self preventMouseEvents.
	self constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignTop ]
]

{ #category : #'instance creation' }
ToAlbumEditsFeedbackElement >> newRawSkin [ 

	^ ToAlbumEditsFeedbackElementSkin new
]
