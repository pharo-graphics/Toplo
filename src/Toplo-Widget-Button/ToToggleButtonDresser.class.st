Class {
	#name : #ToToggleButtonDresser,
	#superclass : #ToCheckableButtonDresser,
	#category : #'Toplo-Widget-Button-Toggle'
}

{ #category : #testing }
ToToggleButtonDresser class >> isDeprecated [ 

	^ true
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonDresser >> checkEvent: anEvent in: anElement [

	super checkEvent: anEvent in: anElement.
	anElement track checked: anElement isChecked
]
