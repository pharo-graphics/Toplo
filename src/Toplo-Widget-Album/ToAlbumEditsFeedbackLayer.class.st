Class {
	#name : #ToAlbumEditsFeedbackLayer,
	#superclass : #ToOverlayElement,
	#instVars : [
		'backgroundAnimation',
		'flashCoverColor',
		'editsFeedback'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'api - attaching / detaching' }
ToAlbumEditsFeedbackLayer >> attachTo: anEditorElement [

	super attachTo: anEditorElement.
	flashCoverColor := Color red alpha: 0.2.

	anEditorElement whenFlashRequestedDo: [ self flash ].
	" flash if save requested with no text change "
	anEditorElement whenSaveRequestedDo: [ :event |
		event unacceptedEdits ifFalse: [ self flash ] ].
	" hide edit feedback when save is accepted or cancelled "
	anEditorElement whenSaveAcceptedDo: [ :event |
		self hideEditsFeedback ].
	anEditorElement whenCancelRequestedDo: [ :event |
		self hideEditsFeedback ].
	" show edit feedback when text is edited "
	anEditorElement whenTextEditedDo: [ :event | self showEditsFeedback ]
]

{ #category : #'api - attaching / detaching' }
ToAlbumEditsFeedbackLayer >> coverWithColor: aCoverColor [

	| previousBackground |
	backgroundAnimation ifNotNil: [ ^ self ].
	previousBackground := self background.
	backgroundAnimation := BlColorTransition new
		                       duration: 500 milliSeconds;
		                       from: aCoverColor;
		                       to: Color transparent;
		                       onStepDo: [ :aColor :anElement | anElement background: aColor ].
	backgroundAnimation onFinishedDo: [ 
		self background: previousBackground.
		backgroundAnimation := nil ].
	self addAnimation: backgroundAnimation
]

{ #category : #accessing }
ToAlbumEditsFeedbackLayer >> editsFeedback [

	^ editsFeedback 
]

{ #category : #'api - attaching / detaching' }
ToAlbumEditsFeedbackLayer >> flash [

	self coverWithColor: flashCoverColor
]

{ #category : #'edition-flag' }
ToAlbumEditsFeedbackLayer >> hideEditsFeedback [

	editsFeedback ifNil: [ ^ self ].
	self removeChild: editsFeedback.
	editsFeedback := nil
]

{ #category : #initialization }
ToAlbumEditsFeedbackLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self preventMeAndChildrenMouseEvents.

]

{ #category : #'edition-flag' }
ToAlbumEditsFeedbackLayer >> newEditsFeedback [

	^ ToAlbumEditsFeedbackElement new
]

{ #category : #'edition-flag' }
ToAlbumEditsFeedbackLayer >> showEditsFeedback [

	editsFeedback ifNotNil: [ ^ self ].
	editsFeedback := self newEditsFeedback.
	self addChild: editsFeedback
]
