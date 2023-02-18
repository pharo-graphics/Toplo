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
	anElement layout cellSpacing: 4.
	anElement icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom))
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]
