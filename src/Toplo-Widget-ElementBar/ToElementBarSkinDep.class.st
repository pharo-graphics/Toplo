Class {
	#name : #ToElementBarSkinDep,
	#superclass : #ToGeneralButtonSkin,
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #'event handling' }
ToElementBarSkinDep >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToElementBarSkinDep >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts ]
]

{ #category : #'accessing - shortcuts' }
ToElementBarSkinDep >> shortcutsToInstallIn: aSelect [

	^ Array streamContents: [ :stream |  ]
]

{ #category : #'event handling' }
ToElementBarSkinDep >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e uninstallShortcuts ]
]
