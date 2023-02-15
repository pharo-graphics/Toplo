Class {
	#name : #ToLabelEditorDresser,
	#superclass : #ToTextFieldDresser,
	#instVars : [
		'editorPosition',
		'label',
		'editorFrameFocusedHandler',
		'editorFrameBlurHandler',
		'editorPlugPositionCheckHandler',
		'editorPositionCheckHandler'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #'instance creation' }
ToLabelEditorDresser class >> label: aLabel [

	^ self new label: aLabel; yourself
]

{ #category : #'api - hooks' }
ToLabelEditorDresser >> defaultBorderWidth [ 

	^ 1
]

{ #category : #accessing }
ToLabelEditorDresser >> label [

	^ label
]

{ #category : #accessing }
ToLabelEditorDresser >> label: aLabel [

	label := aLabel
]

{ #category : #'api - hooks' }
ToLabelEditorDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement fitContent.
	anElement next fitContent.
	anElement infinite fitContent.
	anElement next background: Color transparent.
	label ifNotNil: [ 	
		anElement padding: label padding.
		anElement margin: label margin].

	anElement effect: (BlGaussianShadowEffect
			 color: self defaultBorderColor
			 width: 10
			 offset: 0 asPoint).

	editorFrameFocusedHandler := BlEventHandler
		                             on: BlFocusEvent
		                             do: [
			                             self label ifNotNil: [ :lab |
				                             lab editorFrame toFront ].
			                             anElement effect:
				                             (BlGaussianShadowEffect
					                              color:
					                              self defaultFocusedBorderColor
					                              width: 10
					                              offset: 0 asPoint) ].
	editorFrameBlurHandler := BlEventHandler
		                          on: BlBlurEvent
		                          do: [
			                          anElement effect:
				                          (BlGaussianShadowEffect
					                           color: self defaultBorderColor
					                           width: 10
					                           offset: 0 asPoint) ].

	anElement infinite addEventHandler: editorFrameFocusedHandler.
	anElement infinite addEventHandler: editorFrameBlurHandler.

	" Record start position "
	editorPlugPositionCheckHandler := BlEventHandler
		                                  on: BlElementAddedToSceneGraphEvent
		                                  do: [ " need to wait for the layout to get the actual position "
			                                  anElement whenLayoutedDoOnce: [ editorPosition := anElement positionInSpace ] ].
	" remove the editor in case the position of the editor change "
	" This prevents undesired behavior when a label is in an infinite element"
	editorPositionCheckHandler := BlEventHandler
		                              on: BlElementPositionInSpaceChangedEvent
		                              do: [ :anEvent |
			                              editorPosition ifNotNil: [
				                              editorPosition ~= anElement positionInSpace
					                              ifTrue: [	anElement dispatchEvent: ToLabelEditorRemoveRequestEvent new ] ] ].

	anElement addEventHandler: editorPlugPositionCheckHandler.
	anElement addEventHandler: editorPositionCheckHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabelEditorDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement infinite removeEventHandler: editorFrameFocusedHandler.
	anElement infinite removeEventHandler: editorFrameBlurHandler.
	anElement removeEventHandler: editorPlugPositionCheckHandler.
	anElement removeEventHandler: editorPositionCheckHandler
]
