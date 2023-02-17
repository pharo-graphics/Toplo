Class {
	#name : #ToMenuDresser,
	#superclass : #ToPairedButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]
