Class {
	#name : #ToAlbumPrimarySelectionElement,
	#superclass : #AlbPrimarySelectionElement,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #initialization }
ToAlbumPrimarySelectionElement >> initialize [ 

	super initialize.
	self addEventHandler: ToSkinStateGenerator new.
	self addEventHandler: ToAlbumPrimarySelectionElementEventHandler new
]

{ #category : #skin }
ToAlbumPrimarySelectionElement >> newRawSkin [ 

	^ ToAlbumPrimarySelectionElementSkin new
]

{ #category : #'hooks - children' }
ToAlbumPrimarySelectionElement >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	self requestInstallSkin
]
