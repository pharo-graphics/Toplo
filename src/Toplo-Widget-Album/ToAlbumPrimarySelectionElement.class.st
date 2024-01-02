Class {
	#name : #ToAlbumPrimarySelectionElement,
	#superclass : #AlbPrimarySelectionElement,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #initialization }
ToAlbumPrimarySelectionElement >> initialize [ 

	super initialize.
	self addEventHandler: ToSkinStateGenerator new
]

{ #category : #skin }
ToAlbumPrimarySelectionElement >> installRawStyle [ 

	super installRawStyle.
	"self focusedBackground: (self tokenValueNamed: #'color-primary-selection-focused').
	self unfocusedBackground: (self tokenValueNamed: #'color-primary-selection-unfocused')"
]

{ #category : #'hooks - children' }
ToAlbumPrimarySelectionElement >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	self requestInstallSkin
]
