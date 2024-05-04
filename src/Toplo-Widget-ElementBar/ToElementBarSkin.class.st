Class {
	#name : #ToElementBarSkin,
	#superclass : #ToGeneralButtonSkin,
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #'event handling' }
ToElementBarSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToElementBarSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts ]
]

{ #category : #'accessing - shortcuts' }
ToElementBarSkin >> shortcutsToInstallIn: aSelect [

	^ Array streamContents: [ :stream |  ]
]

{ #category : #'event handling' }
ToElementBarSkin >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e uninstallShortcuts ]
]
