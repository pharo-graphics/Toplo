Class {
	#name : #ToAlbumSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'enablementFeedbackLayer'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #accessing }
ToAlbumSkin >> blurBorderIn: anAlbum [

	^ BlBorder
		  paint: (anAlbum valueOfTokenNamed: #'border-paint')
		  width: (anAlbum valueOfTokenNamed: #'border-width')
]

{ #category : #'event handling' }
ToAlbumSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (self blurBorderIn: e).
		enablementFeedbackLayer ifNil: [
			enablementFeedbackLayer := ToOverlayElement new.			
			enablementFeedbackLayer preventMouseEvents.
			enablementFeedbackLayer background: (e valueOfTokenNamed: #'text-editor-background-disabled').
			enablementFeedbackLayer attachTo: e.
			e addChild: enablementFeedbackLayer ] ]
]

{ #category : #'event handling' }
ToAlbumSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (self blurBorderIn: e).
		enablementFeedbackLayer ifNotNil: [
			enablementFeedbackLayer removeFromParent.
			enablementFeedbackLayer := nil ] ]
]

{ #category : #accessing }
ToAlbumSkin >> focusBorderIn: anAlbum [

	^ BlBorder
		  paint: (anAlbum valueOfTokenNamed: #'focus-border-paint')
		  width: (anAlbum valueOfTokenNamed: #'focus-border-width')
]

{ #category : #'event handling' }
ToAlbumSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (self focusBorderIn: e) ]
]

{ #category : #'event handling' }
ToAlbumSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e isEditable and: [ e isEnabled ])
			ifTrue: [ e mouseCursor: Cursor overEditableText ]
			ifFalse: [ e mouseCursor: Cursor normal ] ]
]

{ #category : #'event handling' }
ToAlbumSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e hasStamp: #'sh-styled')
			ifTrue: [ e styleTable: (e valueOfTokenNamed: #'sh-style-table') ]
			ifFalse: [
				(e hasStamp: #preformatted) ifFalse: [
					e text
						defaultFontSize: (e valueOfTokenNamed: #'font-size');
						lineSpacing: (e valueOfTokenNamed: #'line-height').
					(e hasStamp: #placeholder)
						ifTrue: [ e text foreground: Color gray lighter ]
						ifFalse: [ e text foreground: (e valueOfTokenNamed: #'color-text') ] ] ].

		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius')).
		e margin: BlInsets empty.
		e outskirts: BlOutskirts inside.
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
				 vertical: (e valueOfTokenNamed: #'padding-content-VS')) ]
]

{ #category : #'event handling' }
ToAlbumSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToAlbumSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (self blurBorderIn: e) ]
]

{ #category : #'event handling' }
ToAlbumSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		enablementFeedbackLayer ifNotNil: [
			enablementFeedbackLayer removeFromParent.
			enablementFeedbackLayer := nil ] ]
]
