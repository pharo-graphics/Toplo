Class {
	#name : #ToButtonDangerLook,
	#superclass : #ToButtonLookDecorator,
	#instVars : [
		'background'
	],
	#category : #'Toplo-Widget-Button-Look'
}

{ #category : #accessing }
ToButtonDangerLook >> background [

	^ background ifNil: [ background := false ]
]

{ #category : #accessing }
ToButtonDangerLook >> background: anObject [

	background := anObject
]

{ #category : #private }
ToButtonDangerLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  paint: anElement toTheme colorError;
		  yourself
]

{ #category : #'event handling' }
ToButtonDangerLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorError;
				 build).
		self background ifTrue: [ e background: e toTheme colorError ] ]
]

{ #category : #'event handling' }
ToButtonDangerLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self background ifTrue: [ e background: e toTheme colorErrorHover ].
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorErrorHover;
				 build) ]
]

{ #category : #'event handling' }
ToButtonDangerLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self background ifTrue: [ e background: e toTheme colorError darker ].
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorError darker;
				 build) ]
]
