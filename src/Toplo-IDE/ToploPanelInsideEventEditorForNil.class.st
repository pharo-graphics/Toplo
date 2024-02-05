Class {
	#name : #ToploPanelInsideEventEditorForNil,
	#superclass : #ToploPanelInsideEventEditorAbstract,
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #layout }
ToploPanelInsideEventEditorForNil >> defaultLayout [

	^ SpBoxLayout newVertical add: 'Select a look event listener.'; yourself
]
