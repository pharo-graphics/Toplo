Class {
	#name : #ToChoiceMenuSkin,
	#superclass : #ToMenuSkin,
	#category : #'Toplo-Widget-Menu-Choice menu'
}

{ #category : #'as yet unclassified' }
ToChoiceMenuSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border-disabled')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'as yet unclassified' }
ToChoiceMenuSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'as yet unclassified' }
ToChoiceMenuSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-hover')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'event handling' }
ToChoiceMenuSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e beLabelFirst.
		e flexible: true.
		e interspace: 10.
		e icon: (ToImage inner: (self iconNamed: #bottom)) ]
]

{ #category : #'as yet unclassified' }
ToChoiceMenuSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'as yet unclassified' }
ToChoiceMenuSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-pressed')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]
