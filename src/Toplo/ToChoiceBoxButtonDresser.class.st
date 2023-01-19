Class {
	#name : #ToChoiceBoxButtonDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	anElement icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)).
	anElement icon padding: (BlInsets left: 0 right: 2).
	anElement label ifNotNil: [:l | l padding: (BlInsets left: 2 right: 0) ]

]

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]
