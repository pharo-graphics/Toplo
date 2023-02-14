Class {
	#name : #ToLabelEditorDresser,
	#superclass : #ToDresser,
	#instVars : [
		'editorPosition'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - hooks' }
ToLabelEditorDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement fitContent.
	anElement next fitContent.
	anElement infinite fitContent.
	anElement margin: BlInsets empty.
	anElement padding: BlInsets empty.
	anElement next background: Color transparent.
	anElement outskirts: BlOutskirts outside.
	anElement effect:
		(BlGaussianShadowEffect
			 color: Color black
			 width: 10
			 offset: 0 asPoint).
	" Record start position "
	anElement
		when: BlElementAddedToSceneGraphEvent
		do: [ " need to wait for the layout to get the actual position "
			anElement whenLayoutedDoOnce: [
				editorPosition := anElement positionInSpace ] ].
	" remove the editor in case the position of the editor change "
	" This prevents undesired behavior when a label is in an infinite element"
	anElement
		when: BlElementPositionInSpaceChangedEvent
		do: [ :anEvent |
			editorPosition ifNotNil: [
				editorPosition ~= anElement positionInSpace ifTrue: [
					anElement dispatchEvent: ToLabelEditorRemoveRequestEvent new ] ] ]
]

{ #category : #'api - hooks' }
ToLabelEditorDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]
