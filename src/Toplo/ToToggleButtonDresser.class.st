Class {
	#name : #ToToggleButtonDresser,
	#superclass : #ToCheckableButtonDresser,
	#category : #'Toplo-Widget-Toggle'
}

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonDresser >> checkEvent: anEvent in: anElement [

	super checkEvent: anEvent in: anElement.
	anElement track checked: anElement isChecked
]
