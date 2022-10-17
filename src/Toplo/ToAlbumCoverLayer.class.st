Class {
	#name : #ToAlbumCoverLayer,
	#superclass : #ToAlbumLayer,
	#instVars : [
		'animation'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'api - attaching / detaching' }
ToAlbumCoverLayer >> attachTo: anEditorElement [

	super attachTo: anEditorElement.
	anEditorElement viewModel when: AlbSaveRequested send: #whenSaveRequestedFromModel: to: self.
	anEditorElement viewModel when: ToAlbumCoverRequested send: #whenCoverRequested: to: self
]

{ #category : #'api - attaching / detaching' }
ToAlbumCoverLayer >> coverWithColor: aCoverColor [

	| previousBackground  |
	animation ifNotNil: [ ^ self ].
	previousBackground := self background.
	animation := BlColorTransition new
		duration: 200 milliSeconds;
		from: aCoverColor;
		to: Color transparent;
		onStepDo: [ :aColor :anElement | anElement background: aColor ].
	animation onFinishedDo: [ self background: previousBackground. animation := nil ].
	self addAnimation: animation
]

{ #category : #'api - attaching / detaching' }
ToAlbumCoverLayer >> detach [

	referenceElement viewModel unsubscribe: self.
	super detach
]

{ #category : #initialization }
ToAlbumCoverLayer >> initialize [

	super initialize.
	self background: Color transparent.
	self elevation: (BlRelativeElevation elevation: 1000).
]

{ #category : #'api - attaching / detaching' }
ToAlbumCoverLayer >> whenCoverRequested: aCoverRequestedAnnouncement [

	self coverWithColor: aCoverRequestedAnnouncement background paint color
]

{ #category : #'api - attaching / detaching' }
ToAlbumCoverLayer >> whenSaveRequestedFromModel: aSaveRequestAnnounce [

	aSaveRequestAnnounce viewModel hasUnacceptedEdits ifTrue: [ ^ self ].
	self coverWithColor: Color gray
]
