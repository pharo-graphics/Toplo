Class {
	#name : #ToMenuBarSeparatorDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuBarSeparatorDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: Color lightGray
]
