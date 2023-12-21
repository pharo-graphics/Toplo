Class {
	#name : 'ToChoiceMenuSkin',
	#superclass : 'ToMenuSkin',
	#category : 'Toplo-Widget-Menu-Choice menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Choice menu'
}

{ #category : 'event handling' }
ToChoiceMenuSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border-disabled')
				 width: (e tokenValueNamed: #'line-width')) ]
]

{ #category : 'event handling' }
ToChoiceMenuSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border')
				 width: (e tokenValueNamed: #'line-width')) ]
]

{ #category : 'event handling' }
ToChoiceMenuSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-primary-hover')
				 width: (e tokenValueNamed: #'line-width')) ]
]

{ #category : 'event handling' }
ToChoiceMenuSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e beLabelFirst.
		e flexible: true.
		e interspace: 10.
		e icon: (ToImage inner: (self iconNamed: #bottom)) ]
]

{ #category : 'event handling' }
ToChoiceMenuSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border')
				 width: (e tokenValueNamed: #'line-width')) ]
]

{ #category : 'event handling' }
ToChoiceMenuSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-primary-pressed')
				 width: (e tokenValueNamed: #'line-width')) ]
]
