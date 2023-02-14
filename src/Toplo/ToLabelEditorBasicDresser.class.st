Class {
	#name : #ToLabelEditorBasicDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - hooks' }
ToLabelEditorBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement fitContent.
	anElement next fitContent.
	anElement infinite fitContent.
	anElement margin: BlInsets empty.
	anElement padding: BlInsets empty.
	anElement next background: Color transparent.
	anElement outskirts: (BlOutskirts outside).
	anElement clipChildren: false.


]

{ #category : #'api - hooks' }
ToLabelEditorBasicDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]
