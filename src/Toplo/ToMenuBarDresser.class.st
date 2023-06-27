Class {
	#name : #ToMenuBarDresser,
	#superclass : #ToDresser,
	#instVars : [
		'enterHandler'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: Color transparent.
	anElement border: BlBorder empty.
	anElement padding: (BlInsets all: 4).
	anElement layout cellSpacing: 5
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]
