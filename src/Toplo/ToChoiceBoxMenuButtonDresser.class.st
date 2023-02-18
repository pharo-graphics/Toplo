Class {
	#name : #ToChoiceBoxMenuButtonDresser,
	#superclass : #ToPairedButtonDresser,
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxMenuButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	anElement beLabelFirst.
	anElement icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)).
	anElement icon padding: (BlInsets left: 0 right: 2)
]

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxMenuButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]
