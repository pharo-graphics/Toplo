Class {
	#name : 'ToSwitchButtonSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-Button-Switch',
	#package : 'Toplo-Widget-Button',
	#tag : 'Switch'
}

{ #category : 'event handling' }
ToSwitchButtonSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e | e switchOn ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | e background: (e tokenValueNamed: #'color-primary') ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e | e switchOff ]
]
