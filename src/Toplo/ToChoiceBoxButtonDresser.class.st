Class {
	#name : #ToChoiceBoxButtonDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement beLabelFirst.
	anElement beJustified.
	anElement icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)).
	anElement innerElement hMatchParent.

]

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]
