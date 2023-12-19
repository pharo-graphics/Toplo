Class {
	#name : 'ToSelectInnerButtonSkin',
	#superclass : 'ToButtonSkin',
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'event handling' }
ToSelectInnerButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e beLabelFirst.
		e interspace: 10.
		e icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)) ]
]
