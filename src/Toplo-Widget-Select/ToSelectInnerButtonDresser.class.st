Class {
	#name : #ToSelectInnerButtonDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'api - install/uninstall  hook' }
ToSelectInnerButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement beLabelFirst.
	anElement beJustified.
	anElement icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom))
]

{ #category : #'api - install/uninstall  hook' }
ToSelectInnerButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]
