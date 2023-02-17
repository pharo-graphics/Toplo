Class {
	#name : #ToComboBoxButtonDresser,
	#superclass : #ToPairedButtonDresser,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	anElement beLabelFirst.
	anElement icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)).
	anElement icon padding: (BlInsets left: 0 right: 2).
	anElement label ifNotNil: [:l | l padding: (BlInsets left: 2 right: 0) ]

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]
