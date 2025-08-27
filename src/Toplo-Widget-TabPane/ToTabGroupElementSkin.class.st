Class {
	#name : #ToTabGroupElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'event handling' }
ToTabGroupElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: Color transparent.
			e border: BlBorder empty.
			e isHorizontal
				ifTrue: [
						e menusContainer padding:
							(BlInsets horizontal:
								 (e valueOfTokenNamed: #'padding-content-H')) ]
				ifFalse: [
						e menusContainer padding:
							(BlInsets vertical: (e valueOfTokenNamed: #'padding-content-V')) ] ]
]
