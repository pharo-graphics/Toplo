Class {
	#name : #ToAlbumEditsFeedbackLayer,
	#superclass : #ToWidgetLayer,
	#instVars : [
		'feedback',
		'backgroundAnimation'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - attaching / detaching' }
ToAlbumEditsFeedbackLayer >> attachTo: anEditorElement fromModel: anAlbumModel [

	super attachTo: anEditorElement fromModel: anAlbumModel.
	
	" flash if save requested with no text change "
	anAlbumModel
		when: ToAlbumSaveRequested
		do: [ model unacceptedEditsDo: [ :b | b ifFalse: [ self coverWithColor: Color lightGray ] ] ].

	" visual flag add/remove according to unaccepted edits or not"
	anAlbumModel whenEditStateChangedDo: [ :state | 
		state
			ifTrue: [ self showEditsFeedback ]
			ifFalse: [ self hideEditsFeedback ] ]
]

{ #category : #'api - attaching / detaching' }
ToAlbumEditsFeedbackLayer >> coverWithColor: aCoverColor [

	| previousBackground |
	backgroundAnimation ifNotNil: [ ^ self ].
	previousBackground := self background.
	backgroundAnimation := BlColorTransition new
		                       duration: 200 milliSeconds;
		                       from: aCoverColor;
		                       to: Color transparent;
		                       onStepDo: [ :aColor :anElement | anElement background: aColor ].
	backgroundAnimation onFinishedDo: [ 
		self background: previousBackground.
		backgroundAnimation := nil ].
	self addAnimation: backgroundAnimation
]

{ #category : #'api - attaching / detaching' }
ToAlbumEditsFeedbackLayer >> detach [

	referenceElement viewModel unsubscribe: self.
	super detach
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
	self background: Color transparent
]

{ #category : #'edition-flag' }
ToAlbumEditsFeedbackLayer >> newEditsFeedback [

	| flag |
	flag := BlElement new
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
	^ flag
]

{ #category : #'edition-flag' }
ToAlbumEditsFeedbackLayer >> showEditsFeedback [

	feedback ifNotNil: [ ^ self ].
	feedback := self newEditsFeedback.
	self addChild: feedback 
]
