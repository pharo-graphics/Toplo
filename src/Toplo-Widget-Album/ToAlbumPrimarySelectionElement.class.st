Class {
	#name : #ToAlbumPrimarySelectionElement,
	#superclass : #AlbPrimarySelectionElement,
	#traits : 'TToElement + TToEnableable',
	#classTraits : 'TToElement classTrait + TToEnableable classTrait',
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #initialization }
ToAlbumPrimarySelectionElement >> initialize [ 

	super initialize.
	self initializeForToplo.
	self addEventHandler: ToAlbumPrimarySelectionElementEventHandler new
]

{ #category : #skin }
ToAlbumPrimarySelectionElement >> newRawSkin [ 

	^ ToAlbumPrimarySelectionElementSkin new
]
