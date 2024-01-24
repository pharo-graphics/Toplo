Class {
	#name : #ToAlbumPrimarySelectionElement,
	#superclass : #AlbPrimarySelectionElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
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
