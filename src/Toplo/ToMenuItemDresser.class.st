Class {
	#name : #ToMenuItemDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement background: Color transparent.
	anElement border:  (BlBorder empty).
	anElement padding: (BlInsets all: 2).
	anElement whenClickedDo: [ anElement menuWindow close ]

]
