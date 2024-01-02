Class {
	#name : #ToAlbumEditsFeedbackLayer,
	#superclass : #BlOverlayElement,
	#instVars : [
		'feedback',
		'backgroundAnimation',
		'coverColor'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'api - attaching / detaching' }
ToAlbumEditsFeedbackLayer >> attachTo: anEditorElement [

	super attachTo: anEditorElement.

	coverColor := Color red alpha: 0.1.
	anEditorElement addEventHandler: (BlEventHandler
			 on: ToAlbumFlashRequestedEvent
			 do: [ self flash ]).

	" flash if save requested with no text change "
	anEditorElement addEventHandler: (BlEventHandler
			 on: ToAlbumSaveRequestedEvent
			 do: [ :event | event unacceptedEdits ifFalse: [ self flash ] ]).

	" hide edit feedback when save is accepted "
	anEditorElement addEventHandler: (BlEventHandler
			 on: ToAlbumSaveAcceptedEvent
			 do: [ :event | self hideEditsFeedback ]).

	" show edit feedback when text is edited "
	anEditorElement addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [ :event | self showEditsFeedback ])
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

{ #category : #'api - attaching / detaching' }
ToAlbumEditsFeedbackLayer >> flash [

	self coverWithColor: coverColor
]

{ #category : #'edition-flag' }
ToAlbumEditsFeedbackLayer >> hideEditsFeedback [

	feedback ifNil: [ ^ self ].
	self removeChild: feedback.
	feedback := nil
]

{ #category : #initialization }
ToAlbumEditsFeedbackLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self background: Color transparent.
	self preventMeAndChildrenMouseEvents.

]

{ #category : #'edition-flag' }
ToAlbumEditsFeedbackLayer >> newEditsFeedback [

	| flag |
	flag := BlElement new
		        geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
		        background: ((BlLinearGradientPaint direction: 1 @ 1)
				         start: 25 @ 0;
				         stops: { 
						         (0 -> Color orange).
						         (0.35 -> (Color orange alpha: 0.4)).
						         (0.45 -> (Color orange alpha: 0.1)).
						         (0.50 -> (Color orange alpha: 0.0)).
						         (1 -> Color transparent) });
		        size: 25 @ 25.
	flag constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignTop ].
	flag preventMouseEvents.
	^ flag
]

{ #category : #'edition-flag' }
ToAlbumEditsFeedbackLayer >> showEditsFeedback [

	feedback ifNotNil: [ ^ self ].
	feedback := self newEditsFeedback.
	self addChild: feedback 
]
