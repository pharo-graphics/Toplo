Class {
	#name : #ToLabelSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| tokname from to transition |
		"tokname := anEvent focused
			           ifTrue: [ #'label-selected-focused' ]
			           ifFalse: [ #'label-selected-unfocused' ]."
		to := e valueOfTokenNamed: #'label-foreground-deselected'.
		e text foreground: to.
		"from := e valueOfTokenNamed: tokname.
		transition := BlColorTransition new
			              duration: 100 milliSeconds;
			              from: from;
			              to: to;
			              onStepDo: [ :aColor :anElement |
				              anElement text foreground: aColor ];
			              onFinishedDo: [ e text foreground: to ].
		e addAnimation: transition" ]
]

{ #category : #'event handling' }
ToLabelSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder foreground:
			(e valueOfTokenNamed: #'color-text-disabled').
		e applyAttributesBuilder ]
]

{ #category : #'event handling' }
ToLabelSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder foreground:
			(e valueOfTokenNamed: #'color-text').
		e applyAttributesBuilder ]
]

{ #category : #'event handling' }
ToLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder 
			weight: (e valueOfTokenNamed: #'font-weight-strong');
			defaultFontName: (e valueOfTokenNamed: #'font-family-code');
			defaultFontSize: (e valueOfTokenNamed: #'font-size');
			lineSpacing: (e valueOfTokenNamed: #'line-height').
		e editorBuilder: [ :ed :lab | ed text foreground: (lab valueOfTokenNamed: #'color-text') ].
		e applyAttributesBuilder ]
]

{ #category : #'event handling' }
ToLabelSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| tokname from to transition |
		tokname := anEvent focused
			           ifTrue: [ #'label-selected-focused' ]
			           ifFalse: [ #'label-selected-unfocused' ].
		"from := e valueOfTokenNamed: #'label-foreground-deselected'.
		to := e valueOfTokenNamed: tokname.
		transition := BlColorTransition new
			              duration: 100 milliSeconds;
			              from: from;
			              to: to;
			              onStepDo: [ :aColor :anElement |
				              anElement text foreground: aColor ];
			              onFinishedDo: [ e text foreground: to ].
		e addAnimation: transition"
		e text foreground: (e valueOfTokenNamed: tokname) ]
]
