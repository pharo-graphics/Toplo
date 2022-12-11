Class {
	#name : #ToMenuWindowDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement padding: (BlInsets all: 2).
	anElement background: (Color veryLightGray muchLighter)

]
