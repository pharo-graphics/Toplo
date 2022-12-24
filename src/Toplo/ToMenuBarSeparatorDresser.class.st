Class {
	#name : #ToMenuBarSeparatorDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuBarSeparatorDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: Color lightGray
]
